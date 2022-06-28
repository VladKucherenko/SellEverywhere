/* eslint-disable react/jsx-props-no-spreading */
import Link from "next/link";
import cn from "classnames";

import styles from "./CustomLink.module.scss";

const CustomLink = ({
  href,
  color = "gray-50",
  currentLink = false,
  decoration = "",
  customStyles = "",
  target = "",
  children,
  rel = "",
  ...props
}) => (
  <Link href={href} passHref prefetch={false} {...props}>
    {/* eslint-disable-next-line jsx-a11y/anchor-is-valid */}
    <a
      target={target}
      className={cn(
        styles.link,
        {
          [styles[color]]: styles[color],
          [styles.currentLink]: currentLink,
          [styles[decoration]]: decoration
        },
        customStyles
      )}
      rel={rel}
    >
      {children}
    </a>
  </Link>
);

export default CustomLink;
