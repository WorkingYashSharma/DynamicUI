<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dynamic UI Flutter App</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
            color: #333;
        }
        h1, h2, h3 {
            color: #FF5722;
        }
        h1 {
            font-size: 2.5em;
        }
        h2 {
            font-size: 2em;
        }
        h3 {
            font-size: 1.5em;
        }
        a {
            color: #FF5722;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
        ul {
            padding-left: 20px;
        }
        code {
            background: #eee;
            padding: 4px 6px;
            border-radius: 4px;
            font-family: monospace;
        }
        pre {
            background: #eee;
            padding: 10px;
            border-radius: 6px;
            overflow-x: auto;
        }
        blockquote {
            border-left: 4px solid #FF5722;
            padding-left: 10px;
            color: #555;
            font-style: italic;
        }
        .section {
            margin: 20px;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <div class="section">
        <h1>🌟 Dynamic UI Flutter App</h1>
        <p>
            This is a <b>dynamic UI-based Flutter app</b> that loads its design and content from a remote JSON file named <code>dynamic.json</code>.
            Inspired by apps like <b>Blinkit</b> and <b>Zepto</b>, this app allows you to update its layout and content dynamically by modifying the JSON file, 
            without requiring an app rebuild or update.
        </p>
    </div>

    <div class="section">
        <h2>✨ Features</h2>
        <ul>
            <li><b>🔗 Dynamic JSON-based Content</b>: Fetches all content (banners, categories, offers, and products) from a hosted JSON file.</li>
            <li><b>🎞 Automatic Banner Slider</b>: Smooth, looping slider with automatic transitions and a page indicator.</li>
            <li><b>💸 Horizontal Offers Section</b>: Scrollable section showcasing dynamic promotional offers.</li>
            <li><b>🛍 Grid-based Categories Section</b>: Circular icons representing product categories, loaded dynamically from the JSON file.</li>
            <li><b>🛒 Responsive Product Grid</b>: Displays products with images, prices, and discounts in a grid layout.</li>
            <li><b>🎨 Modern UI Design</b>: Rounded corners, shadows, smooth animations, and consistent spacing.</li>
        </ul>
    </div>

    <div class="section">
        <h2>📁 JSON File Structure</h2>
        <p>The app fetches its content from a hosted JSON file. Below is an example structure of <code>dynamic.json</code>:</p>
        <pre><code>{
    "header": {
        "title": "Dynamic UI App",
        "backgroundColor": "#FF5722"
    },
    "banners": [
        {
            "imageUrl": "https://via.placeholder.com/400x150/FF5722/FFFFFF?text=Fresh+Groceries",
            "width": 350,
            "height": 150
        },
        {
            "imageUrl": "https://via.placeholder.com/400x150/4CAF50/FFFFFF?text=Exclusive+Deals",
            "width": 350,
            "height": 150
        }
    ],
    "offers": [
        {
            "imageUrl": "https://via.placeholder.com/200x100",
            "description": "20% OFF on fresh groceries!"
        },
        {
            "imageUrl": "https://via.placeholder.com/200x100",
            "description": "Buy 1 Get 1 Free on snacks!"
        }
    ],
    "categories": [
        {
            "name": "Fruits & Vegetables",
            "imageUrl": "https://via.placeholder.com/100"
        },
        {
            "name": "Dairy Products",
            "imageUrl": "https://via.placeholder.com/100"
        }
    ],
    "products": [
        {
            "name": "Apple",
            "price": 120,
            "imageUrl": "https://via.placeholder.com/200",
            "discount": 10
        },
        {
            "name": "Milk Packet",
            "price": 50,
            "imageUrl": "https://via.placeholder.com/200",
            "discount": 5
        }
    ]
}</code></pre>
    </div>

    <div class="section">
        <h2>🚀 How It Works</h2>
        <ul>
            <li><b>Fetch Data:</b> The app fetches its content from the <code>dynamic.json</code> file hosted online.</li>
            <li><b>Dynamic Updates:</b> Modify the JSON file, commit the changes, and reopen the app to reflect updates.</li>
            <li><b>Offline Testing:</b> Supports local JSON loading for testing without internet.</li>
        </ul>
    </div>

    <div class="section">
        <h2>🛠 How to Run the App</h2>
        <ol>
            <li>Clone the repository:
                <pre><code>git clone https://github.com/YourUsername/DynamicUIFlutter.git</code></pre>
            </li>
            <li>Navigate to the project directory:
                <pre><code>cd DynamicUIFlutter</code></pre>
            </li>
            <li>Fetch the required dependencies:
                <pre><code>flutter pub get</code></pre>
            </li>
            <li>Run the app:
                <pre><code>flutter run</code></pre>
            </li>
        </ol>
    </div>

    <div class="section">
        <h2>🌐 Hosting the JSON File</h2>
        <p>You can host the <code>dynamic.json</code> file on any platform:</p>
        <ul>
            <li><b>GitHub</b>: Upload the file and use the Raw URL:
                <pre><code>https://raw.githubusercontent.com/YourUsername/YourRepository/main/dynamic.json</code></pre>
            </li>
            <li><b>Firebase</b>: Use Firebase Storage or Realtime Database.</li>
            <li><b>AWS S3 / Google Cloud Storage</b>: Use cloud platforms to generate a public URL.</li>
        </ul>
    </div>

    <div class="section">
        <h2>🔧 Future Enhancements</h2>
        <ul>
            <li>🔍 <b>Search Functionality</b>: Add a feature to search for products dynamically.</li>
            <li>🛒 <b>Shopping Cart</b>: Integrate a cart system for selected products.</li>
            <li>🌐 <b>Localization</b>: Add support for multiple languages.</li>
            <li>🔒 <b>User Authentication</b>: Enable personalized features for authenticated users.</li>
        </ul>
    </div>

    <div class="section">
        <h2>🤝 Contributing</h2>
        <p>We welcome contributions to improve this app. Here's how you can contribute:</p>
        <ol>
            <li>Fork the repository.</li>
            <li>Create a new branch:
                <pre><code>git checkout -b feature/YourFeature</code></pre>
            </li>
            <li>Commit your changes:
                <pre><code>git commit -m "Add YourFeature"</code></pre>
            </li>
            <li>Push to the branch:
                <pre><code>git push origin feature/YourFeature</code></pre>
            </li>
            <li>Open a pull request.</li>
        </ol>
    </div>

    <div class="section">
        <h2>📜 License</h2>
        <p>This project is licensed under the <b>MIT License</b>. See the <code>LICENSE</code> file for details.</p>
    </div>

    <div class="section">
        <h2>📧 Contact</h2>
        <p>If you have any questions or suggestions, feel free to reach out:</p>
        <ul>
            <li><b>Email:</b> your.email@example.com</li>
            <li><b>GitHub:</b> <a href="https://github.com/YourUsername">YourUsername</a></li>
        </ul>
    </div>
</body>
</html>
