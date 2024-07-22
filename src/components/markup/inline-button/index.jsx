import { h } from 'preact';
import style from './index.module.css';
import { useCallback } from "preact/hooks";

import getTagAttributes from 'src/utils/get-tag-attributes';
import { useAtrament, useAtramentState } from 'src/atrament/hooks';

function evaluateInkFunction(atrament, fn) {
  let result;
  try {
    result = atrament.ink.evaluateFunction(fn, [], true); 
  } catch (e) {
    atrament.ink.story().onError(e.toString());
  }
  return result;
}

function setActiveOverlayContent(setStateSubkey, overlayName, content) {
  setStateSubkey('OVERLAY', 'activeOverlay', overlayName);
  let textContent = content;
  const contentArray = content.split('\n');
  const firstLine = contentArray.shift();
  const title = firstLine.match(/\[title\](.+?)\[\/title\]/i);
  if (title) {
    setStateSubkey('OVERLAY', 'title', title[1]);
    textContent = contentArray.join('\n');
  }
  setStateSubkey('OVERLAY', 'content', textContent);
}

const InlineButtonComponent = ({ children, options }) => {
  const { atrament, setStateSubkey } = useAtrament();
  const atramentState = useAtramentState();
  const clickHandler = useCallback(() => {
    const result = evaluateInkFunction(atrament, options.onclick);
    if (result.output) {
      setActiveOverlayContent(setStateSubkey, options.onclick, result.output);
    } else {
      const activeOverlay = atramentState.OVERLAY.activeOverlay;
      if (activeOverlay) {
        // refresh active overlay
        const result = evaluateInkFunction(atrament, activeOverlay);
        setActiveOverlayContent(atrament, activeOverlay, result.output);
      }
    }
  }, [ atrament, setStateSubkey, options.onclick, atramentState ]);
  let buttonStyle = options.bordered === false ? style.inline_button : style.bordered_button;
  return (
    <button
      class={buttonStyle}
      onClick={clickHandler}
      disabled={options.disabled}
    >
      {children}
    </button>
  );
}

export default {
  regexp: /\[button.+?\].+?\[\/button\]/ig,
  replacer: (el, markup) => {
    const fragments = el.match(/\[button(.+?)\](.+?)\[\/button\]/i);
    let attributes = fragments[1];
    if (attributes.startsWith('=')) {
      attributes = `onclick${attributes}`;
    }
    const options = getTagAttributes(attributes);
    return (<InlineButtonComponent options={options}>{markup(fragments[2])}</InlineButtonComponent>);
  }
}
