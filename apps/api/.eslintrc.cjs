/** @type {import("eslint").Linter.Config} */
module.exports = {
  root: true,
  extends: ["@repo/eslint-config/backend.js"],
  parserOptions: {
    project: ["tsconfig.json"],
    tsconfigRootDir: __dirname,
    sourceType: "module",
  },
};
