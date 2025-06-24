# 📝 Flutter Blog App With clean architecture and SOLID principles 

![Made with Flutter](https://img.shields.io/badge/Flutter-Framework-blue.svg)
![State Management: Bloc/Cubit](https://img.shields.io/badge/State--Management-Bloc%20%26%20Cubit-yellow)
![Supabase Backend](https://img.shields.io/badge/Backend-Supabase-green)
![License: MIT](https://img.shields.io/badge/License-MIT-purple.svg)

---

## 🎯 Project Overview

This is a **Full Stack Blog App** built using **Flutter** and structured using the principles of **Clean Architecture**. The goal of this project is to provide a practical, scalable, and testable way of building apps using the **SOLID principles**, **Bloc/Cubit**, **Supabase**, and **Dependency Injection with get_it**.

---

## 🎥 Screenshots

<table style="width: 100%;">
  <tr>
    <td align="center" width="25%">
      <img src="https://i.postimg.cc/BbdKLmML/Screenshot-1750783957.png" width="120"/><br>
      <b>Signup scree</b><br>
      Allow users login or signup
    </td>
    <td align="center" width="25%">
      <img src="https://i.postimg.cc/nMbNRt3H/Screenshot-1750784363.png" width="120"/><br>
      <b>Blog Screen</b><br>
      Displays blogs here
    </td>
     <td align="center" width="25%">
      <img src="https://i.postimg.cc/Gpy7ffst/Screenshot-1750784366.png" width="120"/><br>
      <b>Add blogs</b><br>
      allows users to create and upload blogs
    </td>
    <td align="center" width="25%">
      <img src="https://i.postimg.cc/5yLstKVy/Screenshot-1750784377.png" width="120"/><br>
      <b>Blog details</b><br>
       Display detials of blog
    </td>
   
  </tr>
  </table>

---

## 🚀 What App includes

✅ Clean Architecture in Flutter  
✅ SOLID Principles in practice  
✅ Bloc & Cubit State Management  
✅ Supabase Integration (Auth + DB)  
✅ Dependency Injection using `get_it`  
✅ Layered approach (Data, Domain, Presentation)  
✅ Creating scalable & testable Flutter codebases

---

## 📁 Folder Structure

```bash
lib/
├── core/                # Global utilities and constants
├── data/                # Data sources and models
│   ├── datasources/
│   └── models/
├── domain/              # Entities and repository interfaces
├── presentation/        # UI + Bloc/Cubit files
│   ├── blocs/
│   └── pages/
├── injection.dart       # Dependency Injection setup using get_it
└── main.dart
