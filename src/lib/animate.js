export function animateRef(ref, className) {
  return new Promise((resolve) => {
    ref.addEventListener('animationend', function animationEnd() {
      ref.removeEventListener('animationend', animationEnd);
      ref.classList.remove(className);
      resolve();
    });
    ref.classList.remove(className);
    void ref.offsetWidth;
    ref.classList.add(className);
  });
}
