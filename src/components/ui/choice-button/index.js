import { h } from 'preact';
import style from './index.css';
import { useCallback } from 'preact/hooks';

const ChoiceButton = ({ choice, handleClick }) => {
  const onClick = useCallback(() => {
    handleClick(choice.id);
  }, choice);
  return (
    <button class={style.choice_button} onClick={onClick}>{choice.choice}</button>
  );
};

export default ChoiceButton;
