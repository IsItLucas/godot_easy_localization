# GET - Godot Easy Translations 🌍📝🚀
**GET (Godot Easy Translations)** is a powerful and flexible translation addon for the Godot Engine.
Unlike traditional translation systems that rely on Project Settings, external tools or CSVs, GET is entirely node-based, allowing for dynamic and intuitive text localization directly in the scene.


## 🌟 Features
* 📌 **Node-Based Translation**: Manage translations directly in your scene tree.
* 📖 **Multi-Language Support**: Easily switch between different languages at runtime.
* 🔄 **Dynamic Text Formatting**: Support for formatted text using properties from other nodes.
* ✅ **Conditional Translations**: Change translations based on in-game conditions.
* 🎯 **Targeted Property Translation**: Apply translations to any property of any node.


## 📥 Installation
1. Download or Clone the repository.
2. Place the `addons/` folder inside your Godot project.
3. Enable the plugin in `Project > Project Settings > Plugins`.


## ⚙️ Configuration
1. Go to `Project > Project Settings > Godot Easy > Translation`.
2. Customize the addon's behaviour as you like.
3. You're all set! ✅🎉


## 🚀 Getting Started

### Basic Translation Setup
1. Add a BasicTranslator node to your scene.
2. Assign a StringData resource containing translations.
3. Define NodeTargets for the properties to be translated.
4. Run the project, and the text will update automatically!

### Using Conditional Translations
1. Add a ConditionalTranslator node.
2. Assign two StringData resources (one for each condition outcome).
3. Create TranslationConditions to determine which translation should be applied


## 📖 Documentation
For full documentation, visit the Wiki.


## 🤝 Contributing
We welcome contributions! Feel free to open issues or submit pull requests.


## 📜 License
This project is licensed under the MIT License.

---
Make translations easier and more powerful with GET - Godot Easy Translations! 🌍🚀
