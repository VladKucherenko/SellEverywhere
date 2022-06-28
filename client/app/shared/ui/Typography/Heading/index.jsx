/* eslint-disable react/jsx-props-no-spreading */
import { useRef } from "react";
import cn from "classnames";

import styles from "./heading.module.scss";

const headings = ["h1", "h2", "h3", "h4", "h5", "h6"];

const Heading = ({
  level = 1,
  color = "black",
  weight = "semiBold",
  customStyles,

  children,

  ...rest
}) => {
  const { current: Tag } = useRef(headings[level - 1] || "h1");

  return (
    <Tag
      className={cn(
        styles.heading,

        {
          [styles[Tag]]: Tag,
          [styles[color]]: color,
          [styles[weight]]: weight
        },

        customStyles
      )}
      // eslint-disable-next-line react/jsx-props-no-spreading
      {...rest}
    >
      {children}
    </Tag>
  );
};

export default Heading;
