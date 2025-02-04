# GEL - Godot Easy Localization 🌍📝🚀
**GEL (Godot Easy Localization)** is a powerful and flexible translation addon for the Godot Engine.
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
1. Go to `Project > Project Settings > Godot Easy > Localization`.
2. Customize the addon's behaviour as you like.
3. You're all set! ✅🎉


## 🚀 Getting Started

### Basic Translation Setup
1. Add a ![translator](https://github.com/user-attachments/assets/3db894fb-300f-40c1-8339-f1fffe9d5beb) `Translator` node to your scene.
2. Assign a ![string_data](https://github.com/user-attachments/assets/ceca26ab-de6d-42fa-b2cb-5b63b993c525) `StringData` resource containing translations.
3. Define ![target](https://github.com/user-attachments/assets/f6c2500a-a308-4805-918c-fc6c91b7b730) `NodeTargets` for the properties to be translated.
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
Make translations easier and more powerful with GEL - Godot Easy Localization! 🌍🚀
