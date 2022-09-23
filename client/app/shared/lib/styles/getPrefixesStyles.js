const getPrefixesStyles = (str, prefix, styles) =>
  str
    ?.toString()
    ?.split(" ")
    ?.map(e => styles[`${prefix}${e}`])
    .join(" ");

export default getPrefixesStyles;
