# 🔐 AuthFlow - Node.js Authentication Microservice

A complete authentication microservice built with Node.js, Express, JWT, and MongoDB. Educational project developed to demonstrate security best practices, RESTful API architecture, and containerization with Docker.

## 🚀 Technologies

- **Node.js 20** - JavaScript runtime
- **Express** - Minimalist web framework
- **MongoDB** - NoSQL database
- **JWT** - JSON Web Tokens for authentication
- **Docker & Docker Compose** - Containerization
- **Swagger/OpenAPI 3.0** - API documentation
- **Bcrypt** - Password hashing
- **Helmet** - HTTP headers security
- **Express Rate Limit** - Brute force protection
- **Express Validator** - Data validation

## ✨ Features

- ✅ User registration with validation
- ✅ Login with JWT (Access Token + Refresh Token)
- ✅ Token refresh
- ✅ Logout (refresh token invalidation)
- ✅ Logout from all devices
- ✅ Route protection with authentication middleware
- ✅ Role-based access control (RBAC)
- ✅ Secure password hashing with bcrypt
- ✅ Rate limiting to prevent attacks
- ✅ Input data validation
- ✅ Centralized error handling
- ✅ Complete dockerized structure
- ✅ Interactive API documentation with Swagger

## 📁 Project Structure

```
authflow-node-express/
├── src/
│   ├── config/
│   │   ├── database.js          # MongoDB configuration
│   │   └── swagger.js           # Swagger/OpenAPI configuration
│   ├── controllers/
│   │   ├── auth.controller.js   # Authentication logic
│   │   └── user.controller.js   # User logic
│   ├── middlewares/
│   │   ├── auth.js              # Authentication middleware
│   │   ├── errorHandler.js      # Error handler
│   │   └── validators.js        # Input validators
│   ├── models/
│   │   └── User.js              # User model
│   ├── routes/
│   │   ├── auth.routes.js       # Authentication routes
│   │   └── user.routes.js       # User routes
│   ├── services/
│   │   └── token.service.js     # JWT token service
│   ├── app.js                   # Express configuration
│   └── server.js                # Application entry point
├── .dockerignore
├── .editorconfig
├── .env.examplo
├── .gitignore
├── .nvmrc
├── .prettierrc
├── api-tests.http               # REST Client test collection
├── docker-compose.yml
├── Dockerfile
├── Makefile                     # Command shortcuts
├── package.json
└── README.md
```

## 🐳 How to Run with Docker

### Prerequisites

- Docker
- Docker Compose

### Steps

1. **Clone the repository**

```bash
git clone https://github.com/your-username/authflow-node-express.git
cd authflow-node-express
```

2. **Configure environment variables**

```bash
cp .env.example .env
# Edit the .env file with your settings
```

3. **Start the containers**

```bash
docker-compose up -d
```

4. **Check the logs**

```bash
docker-compose logs -f app
```

5. **Access the API**

```
http://localhost:3000/health
```

### Useful Commands with Makefile

The project includes a `Makefile` with convenient shortcuts:

```bash
# Show available commands
make help

# Install dependencies
make install

# Start containers
make up

# Stop containers
make down

# View application logs
make logs

# View all containers logs
make logs-all

# Restart containers
make restart

# Rebuild images without cache
make rebuild

# Access application container shell
make shell

# Access MongoDB shell
make mongo-shell

# Start Mongo Express for debugging
make mongo-express

# Show containers status
make status

# Clean up (remove containers, volumes, and images)
make clean
```

Or use Docker Compose directly:

```bash
# Start containers
docker-compose up -d

# Stop containers
docker-compose down

# View logs
docker-compose logs -f app

# Rebuild images
docker-compose build --no-cache

# Access container shell
docker exec -it authflow-app sh
```

## 📝 How to Run Locally (without Docker)

1. **Install dependencies**

```bash
npm install
```

2. **Configure MongoDB**

- Install and start MongoDB locally
- Or use MongoDB Atlas (cloud)
- Update the `MONGODB_URI` variable in the `.env` file

3. **Start the server**

```bash
# Development (with nodemon)
npm run dev

# Production
npm start
```

## 📚 API Documentation

The API is fully documented using **Swagger/OpenAPI 3.0**. Once the server is running, you can access the interactive documentation at:

**http://localhost:3000/api-docs**

The Swagger UI provides:

- 📖 Complete API documentation
- 🧪 Interactive endpoint testing
- 📋 Request/response schemas
- 🔐 JWT authentication support
- 💡 Example requests and responses

## 🔌 API Endpoints

### Authentication

#### Register User

```http
POST /api/auth/register
Content-Type: application/json

{
  "name": "Test User",
  "email": "test@example.com",
  "password": "pass123"
}
```

#### Login

```http
POST /api/auth/login
Content-Type: application/json

{
  "email": "test@example.com",
  "password": "pass123"
}
```

**Response:**

```json
{
  "status": "success",
  "message": "Login successful",
  "data": {
    "user": {
      "_id": "...",
      "name": "Test User",
      "email": "test@example.com",
      "role": "user"
    },
    "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
  }
}
```

#### Refresh Token

```http
POST /api/auth/refresh
Content-Type: application/json

{
  "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

#### Logout

```http
POST /api/auth/logout
Authorization: Bearer {accessToken}
Content-Type: application/json

{
  "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

#### Logout from All Devices

```http
POST /api/auth/logout-all
Authorization: Bearer {accessToken}
```

### Users

#### Get Profile

```http
GET /api/users/profile
Authorization: Bearer {accessToken}
```

#### Update Profile

```http
PUT /api/users/profile
Authorization: Bearer {accessToken}
Content-Type: application/json

{
  "name": "Test User Updated"
}
```

#### List All Users (Admin Only)

```http
GET /api/users
Authorization: Bearer {accessToken}
```

### Health Check

```http
GET /health
```

## 🔒 Security

This project implements multiple security layers:

- **Helmet**: HTTP headers protection
- **CORS**: Cross-origin access control
- **Rate Limiting**: Brute force and DDoS protection
- **Bcrypt**: Secure password hashing (10 rounds)
- **JWT**: Secure tokens with expiration
- **Refresh Tokens**: Stored in database and revocable
- **Input Validation**: Express Validator
- **Environment Variables**: Sensitive credentials outside code

## 🎯 Implemented Best Practices

- ✅ Separation of concerns (MVC pattern)
- ✅ Reusable authentication middleware
- ✅ Centralized error handling
- ✅ Input data validation
- ✅ Containerization with Docker
- ✅ Environment variables for configuration
- ✅ Structured logging
- ✅ Clean and documented code
- ✅ Multi-stage Docker build
- ✅ Health check endpoints
- ✅ Interactive API documentation (Swagger)
- ✅ Makefile for easy command execution

## 📊 Environment Variables

Create a `.env` file based on `.env.example`:

| Variable                 | Description                  | Default                          |
| ------------------------ | ---------------------------- | -------------------------------- |
| `NODE_ENV`               | Execution environment        | `development`                    |
| `PORT`                   | Server port                  | `3000`                           |
| `MONGODB_URI`            | MongoDB connection URI       | `mongodb://mongo:27017/authflow` |
| `JWT_SECRET`             | JWT access token secret      | -                                |
| `JWT_REFRESH_SECRET`     | JWT refresh token secret     | -                                |
| `JWT_EXPIRES_IN`         | Access token expiration time | `15m`                            |
| `JWT_REFRESH_EXPIRES_IN` | Refresh token expiration     | `7d`                             |
| `BCRYPT_ROUNDS`          | Bcrypt rounds                | `10`                             |

## 🧪 Testing the API

### Option 1: Swagger UI (Recommended)

Access the interactive documentation at `http://localhost:3000/api-docs` and test all endpoints directly from your browser.

### Option 2: Command Line Tools

Use tools like [curl](https://curl.se/), [Postman](https://www.postman.com/), [Insomnia](https://insomnia.rest/), or [HTTPie](https://httpie.io/):

```bash
# Health check
curl http://localhost:3000/health

# Register user
curl -X POST http://localhost:3000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"name":"Test User","email":"test@example.com","password":"pass123"}'

# Login
curl -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"pass123"}'
```

## 🤝 Contributing

This is an educational project, but suggestions are welcome!

1. Fork the project
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is under the MIT license. See the [LICENSE](LICENSE) file for more details.

## 👨‍💻 Author

Developed as a portfolio project to demonstrate knowledge in:

- Backend Development with Node.js
- RESTful APIs
- Authentication and Security
- Containerization with Docker
- Development best practices

---

⭐ If this project was helpful to you, consider giving it a star!
