<div align="center">
   <h1 align="center">Eclipse Translations</h1>
   <p align="center">
        A repository for Eclipse Menu translations.
   </p>
</div>
<div align="center">
    <a href="https://translate.eclipse.menu/engage/eclipse/">
        <img src="https://translate.eclipse.menu/widget/eclipse/translations/svg-badge.svg" alt="Translation status" />
    </a>
</div>

<div align="center">
    <img src="https://translate.eclipse.menu/widget/eclipse/translations/multi-auto.svg" alt="Languages"/>
</div>

## How to contribute
### Using web interface
1. Go to the [Weblate project](https://translate.eclipse.menu/engage/eclipse/)
2. Sign in or create an account
3. Start translating

### Manual translations
1. Fork this repository
2. Add or edit translations in the `translations` folder (see [adding languages](#adding-languages) for more information)
3. Create a pull request
4. Wait for your pull request to be reviewed and merged

## Adding languages
Language files are stored as JSON files, that contain metadata and key-value pairs for each translation.

Metadata is stored at the top of the file, and contains the following fields:
```json5
{
    "language-name": "English",    // The name of the language in English
    "language-native": "English",  // The name of the language in its native form.
    "language-charset": "default", // The character set of the language
    "language-fallback": "en_US",  // The fallback language code (defaults to English)
    
    // ... translations go here
}
```

`language-name`, and `language-native` are required and should be self-explanatory.

`language-charset` is optional and defaults to `default`.
If the language uses a different character set, you can specify it here.
Supported values are:
- `default`
- `greek`
- `korean`
- `japanese`
- `chinese-full`
- `chinese-simplified`
- `cyrillic`
- `thai`
- `vietnamese`

This will tell Eclipse which font to use for the language.

`language-fallback` is optional and defaults to `en_US`.
If a translation is missing for a key in the current language,
Eclipse will fall back to the specified language.
You can use this to avoid duplicating translations for similar languages.

> Note: this field is not recursive, so if a translation is missing in the fallback language, it will not fall back further.