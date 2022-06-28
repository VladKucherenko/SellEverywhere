/* eslint-disable react/jsx-props-no-spreading */
import cn from "classnames";

import styles from "./text.module.scss";

export default function Text({
  size = "md",
  color = "gray",
  weight,
  tag,
  customStyles = "",
  children,
  ...rest
}) {
  const Tag = tag || "p";

  return (
    <Tag
      className={cn(
        styles.text,
        {
          [styles[size]]: size,
          [styles[`font-${size}`]]: size,
          [styles[color]]: color,
          [styles[weight]]: weight
        },
        customStyles
      )}
      {...rest}
    >
      {children}
    </Tag>
  );
}
