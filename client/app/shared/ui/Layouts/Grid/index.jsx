/* eslint-disable react/jsx-props-no-spreading */
import cn from "classnames";

import { getPrefixesStyles } from "../../../lib/";
import extractFromStyles from "../../../lib/styles/extractFromStyles";

import styles from "./grid.module.scss";

export default function Grid({
  as,
  children,
  cols = null,
  rows = null,
  gap = null,
  columnGap = null,
  rowGap = null,
  customStyles,
  ...rest
}) {
  const Tag = as || "div";

  return (
    <Tag
      className={cn(
        styles.grid,
        {
          [styles[`gap-${gap}`]]: gap,
          [styles[`column-gap-${columnGap}`]]: columnGap,
          [styles[`row-gap-${rowGap}`]]: rowGap
        },
        extractFromStyles(
          styles,
          cols,
          "cols-",
          /\s/.test(cols),
          getPrefixesStyles(cols, "cols-", styles)
        ),
        extractFromStyles(
          styles,
          rows,
          "rows-",
          /\s/.test(rows),
          getPrefixesStyles(rows, "rows-", styles)
        ),
        customStyles
      )}
      {...rest}
    >
      {children}
    </Tag>
  );
}
