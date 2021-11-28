module.exports = {
  parser: `@typescript-eslint/parser`,
  parserOptions: {
    ecmaVersion: 2020,
    sourceType: `module`,
    ecmaFeatures: {
      jsx: true,
    },
  },
  plugins: [`simple-import-sort`],
  settings: {
    react: {
      version: `detect`,
    },
  },
  extends: [
    `plugin:react/recommended`,
    `plugin:@typescript-eslint/recommended`,
    `prettier`,
    `plugin:prettier/recommended`,
  ],
  rules: {
    '@typescript-eslint/indent': 'off',
    '@typescript-eslint/no-var-requires': 0,
    'simple-import-sort/imports': [
      'error',
      {
        groups: [
          // Non-side effect imports.
          ['^[^\\u0000]'],
          // Side effect imports.
          ['^\\u0000'],
        ],
      },
    ],
    'simple-import-sort/exports': 'error',
    'sort-imports': 'off',
  },
  overrides: [
    {
      files: [`**/*.tsx`],
      rules: {
        'react/prop-types': `off`,
      },
    },
  ],
}
