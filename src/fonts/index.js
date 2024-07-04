// font styles
import { gameDefaultFont } from 'src/constants';

import 'src/fonts/fira-sans/index.css';
import 'src/fonts/lora/index.css';
import 'src/fonts/merriweather/index.css';
import 'src/fonts/opendyslexic/index.css';

export const fonts = {
  System: '-apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol"',
  'Fira Sans': '"Fira Sans", sans-serif',
  Lora: '"Lora", serif',
  Merriweather: '"Merriweather", serif',
  OpenDyslexic: '"OpenDyslexic", serif'
};
  
export function applyFont(font) {
  document.documentElement.style.setProperty('--font-game', fonts[font] || fonts[gameDefaultFont]);
}
