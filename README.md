# finance-dashboard

## 📌 How to Run the App

### **1️⃣ Clone the Repository**

```sh
git clone https://github.com/your-username/finance-dashboard.git
cd finance-dashboard
```

## Project setup

```
npm install
```

### Compiles and hot-reloads for development

```
npm run serve
```

📌 How to Run the App Using Docker 🐳

### 1️⃣ Build the Docker Image

```
docker build -t skiresult-dashboard .
```

### 2️⃣ Run the Docker Container

```
docker run -d -p 8080:80 --name skiresult-app skiresult-dashboard

```

### 3️⃣ Open the App

```
http://localhost:8080
```

### Compiles and minifies for production

```
npm run build
```

### Lints and fixes files

```
npm run lint
```

### Customize configuration

See [Configuration Reference](https://cli.vuejs.org/config/).

# SkiResult Expense Dashboard

A **Vue 2 + Vuetify** web application that displays **company expenses** in both a **table** and a **chart** with filtering options.

---

## 📌 Features

✅ **Displays Expenses in a Table** (with Pagination & Sorting)  
✅ **Visualizes Monthly Expenses in a Chart** (Bar Chart)  
✅ **Filter Expenses by Vendor (Search Box)**  
✅ **Filter Expenses by GL Account (Dropdown)**  
✅ **Modern & Responsive UI** (Vuetify Design)  
✅ **Interactive Pagination with Arrows**

---

## 📌 Tech Stack

- **Vue 2**
- **Vuetify**
- **Chart.js**
- **JavaScript (ES6)**
- **Node.js (for package management)**
