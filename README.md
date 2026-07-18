# Fitness Tracker

A simplified Fitness Management Web Application using Java Servlets, JSP, JDBC, MySQL, and Maven with clean layered architecture.

## 🏋️ Features

### Authentication Module
- User registration with role selection (User/Trainer)
- Secure login system
- Role-based dashboard access
- Session management

### Admin Module
- Add and manage trainers
- View system statistics
- Complete trainer management

### Trainer Module
- Create workout plans
- Design diet plans
- Manage fitness programs

### User Module
- View available workout plans
- Access diet plans
- Personal fitness dashboard

## 🏗️ Architecture

### Technology Stack
- **Backend**: Java Servlets, JDBC
- **Frontend**: JSP, HTML5, CSS3, Bootstrap 5
- **Database**: MySQL
- **Build Tool**: Maven
- **Server**: Apache Tomcat

### Package Structure
```
com.fitnesstracker/
├── controller/          # Servlet Controllers
│   ├── LoginController.java
│   ├── UserController.java
│   ├── TrainerController.java
│   ├── WorkoutController.java
│   └── DietController.java
├── dao/                 # Data Access Objects
│   ├── UserDAO.java
│   ├── TrainerDAO.java
│   ├── WorkoutDAO.java
│   └── DietDAO.java
├── dto/                 # Data Transfer Objects
│   ├── UserDTO.java
│   ├── TrainerDTO.java
│   ├── WorkoutDTO.java
│   └── DietDTO.java
└── util/                # Utility Classes
    └── DBUtil.java
```

## 🚀 Getting Started

### Prerequisites
- Java 11 or higher
- Apache Maven 3.6+
- MySQL 8.0+
- Apache Tomcat 10+

### Database Setup
1. Create MySQL database named `fitness_db`
2. Execute the database schema:
```bash
mysql -u root -p < database_schema.sql
```

### Build and Run
#### Option 1: Using Build Script (Windows)
```bash
./build-and-run.bat
```

#### Option 2: Manual Maven Commands
```bash
# Build the project
mvn clean package

# Run on embedded Tomcat
mvn tomcat10:run
```

#### Option 3: Deploy to External Tomcat
```bash
# Build WAR file
mvn clean package

# Deploy to Tomcat
cp target/fitnesstracker.war $TOMCAT_HOME/webapps/
```

## 🌐 Access the Application

- **Landing Page**: http://localhost:8080/fitnesstracker/
- **Login**: http://localhost:8080/fitnesstracker/login.jsp
- **Register**: http://localhost:8080/fitnesstracker/register.jsp

### Default Login Credentials
- **Admin**: admin@fitness.com / admin123
- **Sample User**: alice@fitness.com / alice123
- **Sample Trainer**: carol@fitness.com / carol123

## 📊 Database Schema

### Core Tables
- **users** - User accounts and authentication
- **trainers** - Trainer information
- **workout** - Workout programs
- **diet_plan** - Diet plans

### Sample Data
The database schema includes sample data for testing all features.

## 🎯 Key Features

### Simplicity First
- Clean, minimal codebase
- Easy to understand and extend
- Focused on core functionality

### Modern Technology
- Jakarta EE namespace
- Bootstrap 5 responsive design
- Maven build system

### Role-Based Access
- Admin: System management
- Trainer: Program creation
- User: View and track progress

## 🔧 Configuration

### Database Settings
Update database credentials in `DBUtil.java`:
```java
private static final String URL = "jdbc:mysql://localhost:3306/fitness_db";
private static final String USERNAME = "root";
private static final String PASSWORD = "password";
```

### Server Configuration
- Default port: 8080
- Context path: /fitnesstracker
- Session timeout: 30 minutes

## 📝 Project Structure

```
fitnesstracker/
├── pom.xml                    # Maven configuration
├── database_schema.sql        # Database setup
├── build-and-run.bat          # Build script
├── README.md                  # Project documentation
└── src/
    └── main/
        ├── java/
        │   └── com/fitnesstracker/
        │       ├── controller/
        │       ├── dao/
        │       ├── dto/
        │       └── util/
        └── webapp/
            ├── css/
            ├── js/
            ├── images/
            ├── WEB-INF/
            │   └── web.xml
            ├── index.jsp
            ├── login.jsp
            ├── register.jsp
            ├── admin-dashboard.jsp
            ├── trainer-dashboard.jsp
            ├── user-dashboard.jsp
            └── logout.jsp
```

## 🎉 Benefits

### For Learning
- Clean MVC architecture
- Easy to understand code
- Perfect for Java web development learning

### For Development
- Minimal dependencies
- Fast setup and deployment
- Easy customization and extension

### For Production
- Secure authentication
- Role-based access control
- Scalable architecture

---

**Built with ❤️ for fitness enthusiasts and developers!**
