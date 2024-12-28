const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
  content: [
    "./public/*.html",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/views/**/*.{erb,haml,html,slim}",
    "./app/components/**/*.{erb,haml,html,slim}",
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: [
          "Playfair Display",
          "Inter var",
          ...defaultTheme.fontFamily.sans,
        ],
        serif: ["Lato", ...defaultTheme.fontFamily.serif],
      },
      boxShadow: {
        custom:
          "0 1px 2px 0 rgba(60, 64, 67, 0.302), 0 2px 6px 2px rgba(60, 64, 67, 0.149)",
      },
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    require("@tailwindcss/typography"),
    require("@tailwindcss/container-queries"),
  ],
};
