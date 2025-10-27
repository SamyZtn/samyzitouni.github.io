document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll("details[data-animate]").forEach((details) => {
    const content = details.querySelector(".pub-abstract__content");
    if (!content) return;

    details.addEventListener("toggle", () => {
      const isOpening = details.open;
      const startHeight = isOpening ? 0 : content.scrollHeight;
      const endHeight = isOpening ? content.scrollHeight : 0;

      content.style.height = startHeight + "px";
      requestAnimationFrame(() => {
        content.style.transition = "height 0.25s ease, opacity 0.25s ease";
        content.style.height = endHeight + "px";
        content.style.opacity = isOpening ? "1" : "0";
      });

      const end = () => {
        if (isOpening) content.style.height = "auto";
        content.style.transition = "";
        content.removeEventListener("transitionend", end);
      };
      content.addEventListener("transitionend", end);
    });
  });
});
