export default function extractFromStyles(
  styles,
  string,
  prefix = null,
  condition,
  conditionFn
) {
  if (condition) {
    return conditionFn;
  }

  return styles[`${prefix || ""}${string}`];
}
