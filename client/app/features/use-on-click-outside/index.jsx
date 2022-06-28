import { useEffect } from "react";

const useOnClickOutside = (ref, handler, isOpen, banRef = null) => {
  useEffect(() => {
    const listener = event => {
      const el = ref?.current;
      if (
        !el ||
        el.contains(event?.target || null) ||
        el.contains(banRef?.current || null) ||
        event.target.isEqualNode(banRef?.current)
      ) {
        return;
      }

      handler(event); // Call the handler only if the click is outside of the element passed.
    };

    document.addEventListener("mousedown", listener);
    document.addEventListener("touchstart", listener);

    return () => {
      document.removeEventListener("mousedown", listener);
      document.removeEventListener("touchstart", listener);
    };
  }, [ref, handler, isOpen, banRef]); // Reload only if ref or handler changes
};

export default useOnClickOutside;
