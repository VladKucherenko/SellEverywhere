import noop from "lodash/noop";
import cn from "classnames";
import styles from "./Button.module.scss";

export const Button = ({
  type = "button",
  onClick = noop,
  rounded = false,
  color = "",
  customWrapStyles = "",
  customBtnStyles = "",
  disabled = false,
  icon = false,
  children
}) => (
  <div
    className={cn(styles.btn__wrapper, customWrapStyles, {
      [styles.icon]: icon
    })}
  >
    <button
      // eslint-disable-next-line react/button-has-type
      type={type}
      className={cn(
        styles.btn,
        {
          [styles.btn__rounded]: rounded,
          [styles[color]]: styles[color]
        },
        customBtnStyles
      )}
      onClick={onClick}
      disabled={disabled}
    >
      {children}
    </button>
  </div>
);
