# School Management System - iOS App

## Overview
An AI-powered school management system built with SwiftUI and SwiftData. This app provides a comprehensive corporate website section for managing multiple schools, programs, teachers, activities, news, and careers.

## Project Architecture

### Corporate Section (Public Access)
The main domain layer provides public access to:

1. **Homepage** - Dashboard with featured schools, latest news, and quick links
2. **About** - Mission, vision, values, and leadership information
3. **Programs** - Browse and enroll in educational programs
4. **Teachers Portfolio** - View teacher profiles and qualifications
5. **Activities** - Explore extracurricular activities
6. **Careers** - Job listings and application portal
7. **News** - Latest updates and announcements
8. **Contact** - Contact form and information
9. **Agentic Chatbot** - AI assistant for queries
10. **Schools** - List of all schools in the system
11. **Admin Panel** - Secure login for administrators

## App Screenshots

### Corporate Website Section

#### 1. Home Dashboard
<img src="screenshots/home-dashboard.png" width="300" alt="Home Dashboard">

The main dashboard featuring:
- Featured schools carousel
- Latest news section
- Quick access to programs
- Statistics overview
- Call-to-action buttons

#### 2. About Us
<img src="screenshots/about-us.png" width="300" alt="About Us">

Organization information including:
- Mission statement
- Vision and values
- Leadership team
- Organizational overview

#### 3. Programs
<img src="screenshots/programs.png" width="300" alt="Programs">

Educational programs with:
- Filterable program list (All, Academic, Vocational, Technical)
- Program details (duration, fees, description)
- Enrollment information
- Search functionality

#### 4. Teachers Portfolio
<img src="screenshots/teachers.png" width="300" alt="Teachers Portfolio">

Teacher directory featuring:
- Teacher profiles with photos
- Qualifications and specializations
- Experience and expertise
- Search and filter options

#### 5. Activities
<img src="screenshots/activities.png" width="300" alt="Activities">

Extracurricular activities:
- Sports programs
- Arts and culture
- Clubs and societies
- Schedule and participation details

#### 6. Careers
<img src="screenshots/careers.png" width="300" alt="Careers">

Job portal with:
- Current job openings
- Position details (type, department, location)
- Application form
- Salary ranges

#### 7. News & Updates
<img src="screenshots/news.png" width="300" alt="News">

Latest announcements:
- News articles with images
- Publication dates
- Article details
- Categories and tags

#### 8. Schools Directory
<img src="screenshots/schools.png" width="300" alt="Schools Directory">

All schools in the system:
- School listings with logos
- Location and contact info
- Student capacity
- Establishment year

#### 9. Contact Form
<img src="screenshots/contact.png" width="300" alt="Contact">

Get in touch:
- Contact form with validation
- Name, email, subject, message
- Social media links
- Office information

#### 10. AI Chatbot
<img src="screenshots/chatbot.png" width="300" alt="AI Chatbot">

Intelligent assistant:
- Real-time chat interface
- Contextual responses
- Help and guidance
- Common queries handling

#### 11. Admin Login
<img src="screenshots/admin-login.png" width="300" alt="Admin Login">

Secure authentication:
- Username and password fields
- Role-based access
- Security features
- Password recovery (future)

#### 12. More Options
<img src="screenshots/more.png" width="300" alt="More Menu">

Additional features:
- Settings
- Help & Support
- About
- Legal information

### Navigation
<img src="screenshots/tab-navigation.png" width="300" alt="Tab Navigation">

Easy tab-based navigation with 5 main sections:
- 🏠 Home
- 📰 News
- 🎓 Schools
- 💬 Chat
- ⚙️ More

---

> **Note:** To add actual screenshots to this README:
> 1. Run the app on simulator
> 2. Take screenshots (Cmd+S in simulator)
> 3. Create a `screenshots/` folder in the repository
> 4. Add your screenshots with the filenames shown above
> 5. The images will automatically appear in the README

---

## Features Implemented

### Models (SwiftData)
- ✅ School - School information and details
- ✅ Teacher - Teacher profiles and qualifications
- ✅ NewsArticle - News and announcements
- ✅ Program - Educational programs
- ✅ Activity - Extracurricular activities
- ✅ Career - Job postings

### Views
- ✅ CorporateHomeView - Main tab navigation
- ✅ HomeView - Dashboard with featured content
- ✅ AboutView - About us section
- ✅ ProgramsView - Programs listing and details
- ✅ TeachersView - Teachers portfolio
- ✅ ActivitiesView - Activities listing
- ✅ CareersView - Career opportunities
- ✅ NewsListView - News articles
- ✅ SchoolsListView - Schools directory
- ✅ ContactView - Contact form
- ✅ ChatbotView - AI chatbot assistant
- ✅ AdminLoginView - Admin authentication

### Key Features
- **Tab-based Navigation** - Easy access to main sections
- **Search & Filter** - Find content quickly
- **CRUD Operations** - Add, view, edit content
- **Responsive Design** - Beautiful iOS-native UI
- **Sample Data** - Pre-populated test data
- **SwiftData Integration** - Persistent storage

## Usage

### Running the App
1. Open the project in Xcode
2. Select a simulator or device
3. Build and run (Cmd+R)

### Adding Sample Data
To populate the app with sample data for testing:

```swift
// In your view or app initialization
SampleData.populateAllSampleData(modelContext: modelContext)
```

### Admin Login Credentials
- Username: `admin`
- Password: `admin123`

## Project Structure

```
School/
├── Models/
│   ├── School.swift
│   ├── Teacher.swift
│   ├── NewsArticle.swift
│   ├── Program.swift
│   ├── Activity.swift
│   └── Career.swift
├── Views/
│   └── Corporate/
│       ├── CorporateHomeView.swift
│       ├── HomeView.swift
│       ├── AboutView.swift
│       ├── ProgramsView.swift
│       ├── TeachersView.swift
│       ├── ActivitiesView.swift
│       ├── CareersView.swift
│       ├── NewsListView.swift
│       ├── SchoolsListView.swift
│       ├── ContactView.swift
│       ├── ChatbotView.swift
│       ├── AdminLoginView.swift
│       └── MoreView.swift
├── Helpers/
│   └── SampleData.swift
├── SchoolApp.swift
└── ContentView.swift
```

## Next Steps

### School-Specific Sections (To be implemented)
Each school will have its own management system:
- Role-based authentication
- Home/Dashboard
- Courses Management
- Academic & Performance System
- Exam, Assessment & Timetable
- Analytics & Reporting
- Financial Management
- Attendance & Leave Management
- Careers & Teacher Portfolio
- News & Contact

### Super Admin Features (To be implemented)
- Monitor all schools
- Manage administrators
- System-wide reporting
- Global settings

## Technologies Used
- SwiftUI - Modern declarative UI framework
- SwiftData - Apple's data persistence framework
- iOS 17+ - Latest iOS features

## Design Principles
- **User-Centric** - Intuitive and easy to navigate
- **Responsive** - Works on all iOS devices
- **Consistent** - Unified design language
- **Accessible** - Follows iOS accessibility guidelines

## Contributing
This is the initial corporate section implementation. Future updates will include:
- School-specific admin panels
- Advanced analytics
- Push notifications
- Enhanced AI chatbot
- Document management
- Parent portal
- Student portal

## License
Proprietary - All rights reserved

## Contact
For questions or support, please contact the development team.

---

**Version:** 1.0.0 - Corporate Section
**Last Updated:** December 2, 2025
**Status:** ✅ Corporate Section Complete, 🚧 School Sections In Progress
