import { h } from 'preact';
import style from './index.css';
// UI
import Block from '../block';

const ContainerChoices = ({ children, key, isReady }) => {
  return (
    <div key={key} class={[style.container_choices, 'atrament-container-choices', isReady ? 'animation_appear' : ''].join(' ')}>
      <div style={{ opacity: isReady ? 1 : 0 }}>
        <Block>
          {children}
        </Block>
      </div>
    </div>
  )
};

export default ContainerChoices;