/* eslint-disable react/jsx-props-no-spreading */
import { forwardRef } from "react";
import cn from "classnames";

import styles from "./flex.module.scss";

const Flex = forwardRef(
  (
    {
      as,
      x = "center",
      y = "center",
      gap = 0,
      direction = "row",
      customStyles = "",
      onHandleClick,
      wrap = false,
      w,
      children,
      ...rest
    },
    ref
  ) => {
    const Tag = as || "div";

    return (
      <Tag
        ref={ref}
        className={cn(
          styles.flex,

          {
            [styles[`x-${x}`]]: x,
            [styles[`y-${y}`]]: y,
            [styles[`gap-${direction}-${gap}`]]: gap,
            [styles[direction]]: direction,

            [styles[wrap]]: wrap,

            [styles[`w-${w}`]]: w
          },

          customStyles
        )}
        onClick={onHandleClick}
        // eslint-disable-next-line react/jsx-props-no-spreading
        {...rest}
      >
        {children}
      </Tag>
    );
  }
);
Flex.displayName = "Flex";

export default Flex;
