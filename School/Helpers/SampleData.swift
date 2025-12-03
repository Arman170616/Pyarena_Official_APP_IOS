//
//  SampleData.swift
//  School
//
//  Created by FutureInnvo on 02/12/2025.
//

import Foundation
import SwiftData

class SampleData {
    static func createSampleSchools(modelContext: ModelContext) {
        let school1 = School(
            name: "Binnazhara School",
            address: "123 Education Street, City Center",
            phoneNumber: "+1 (555) 111-2222",
            email: "info@binnazhara.edu",
            schoolDescription: "Binnazhara School provides excellence in education with state-of-the-art facilities and experienced faculty. We focus on holistic development of students through academic excellence and extracurricular activities.",
            establishedYear: 2005
        )
        
        let school2 = School(
            name: "Al Noor School",
            address: "456 Knowledge Avenue, East District",
            phoneNumber: "+1 (555) 333-4444",
            email: "contact@alnoor.edu",
            schoolDescription: "Al Noor School is dedicated to nurturing young minds through innovative teaching methods and comprehensive curriculum. We emphasize both traditional values and modern education.",
            establishedYear: 2010
        )
        
        let school3 = School(
            name: "International School",
            address: "789 Global Plaza, West Zone",
            phoneNumber: "+1 (555) 555-6666",
            email: "admissions@international.edu",
            schoolDescription: "International School offers world-class education following international curriculum standards. Our diverse community prepares students for global citizenship.",
            establishedYear: 2015
        )
        
        modelContext.insert(school1)
        modelContext.insert(school2)
        modelContext.insert(school3)
    }
    
    static func createSampleTeachers(modelContext: ModelContext) {
        let teachers = [
            Teacher(
                name: "Dr. Sarah Johnson",
                subject: "Mathematics",
                qualification: "PhD in Mathematics Education",
                experience: 15,
                bio: "Dr. Johnson has dedicated her career to making mathematics accessible and engaging for students of all levels. She specializes in innovative teaching methods.",
                email: "s.johnson@school.edu",
                phoneNumber: "+1 (555) 111-1111"
            ),
            Teacher(
                name: "Prof. Ahmed Khan",
                subject: "Science",
                qualification: "MSc in Physics",
                experience: 12,
                bio: "Professor Khan brings his passion for science to the classroom, inspiring students to explore the wonders of the natural world through hands-on experiments.",
                email: "a.khan@school.edu",
                phoneNumber: "+1 (555) 222-2222"
            ),
            Teacher(
                name: "Ms. Maria Garcia",
                subject: "English Literature",
                qualification: "MA in English",
                experience: 10,
                bio: "Ms. Garcia loves helping students discover the joy of reading and writing. She creates an engaging environment where creativity flourishes.",
                email: "m.garcia@school.edu",
                phoneNumber: "+1 (555) 333-3333"
            ),
            Teacher(
                name: "Mr. David Lee",
                subject: "Computer Science",
                qualification: "MS in Computer Science",
                experience: 8,
                bio: "Mr. Lee is passionate about preparing students for the digital age. He teaches programming, web development, and emerging technologies.",
                email: "d.lee@school.edu",
                phoneNumber: "+1 (555) 444-4444"
            )
        ]
        
        teachers.forEach { modelContext.insert($0) }
    }
    
    static func createSamplePrograms(modelContext: ModelContext) {
        let programs = [
            Program(
                name: "Primary Education",
                programDescription: "Comprehensive primary education focusing on foundational skills in reading, writing, mathematics, and social development.",
                duration: "6 Years",
                ageGroup: "Ages 6-12",
                fee: 5000,
                curriculum: "National Curriculum"
            ),
            Program(
                name: "Secondary Education",
                programDescription: "Advanced secondary education preparing students for higher education with focus on critical thinking and academic excellence.",
                duration: "4 Years",
                ageGroup: "Ages 13-16",
                fee: 7000,
                curriculum: "International Baccalaureate"
            ),
            Program(
                name: "STEM Program",
                programDescription: "Specialized program in Science, Technology, Engineering, and Mathematics with hands-on learning and project-based curriculum.",
                duration: "2 Years",
                ageGroup: "Ages 14-18",
                fee: 8500,
                curriculum: "Advanced STEM Curriculum"
            ),
            Program(
                name: "Arts & Humanities",
                programDescription: "Comprehensive arts education including visual arts, music, drama, and literature with focus on creative expression.",
                duration: "2 Years",
                ageGroup: "Ages 14-18",
                fee: 6500,
                curriculum: "Arts & Humanities Curriculum"
            )
        ]
        
        programs.forEach { modelContext.insert($0) }
    }
    
    static func createSampleActivities(modelContext: ModelContext) {
        let activities = [
            Activity(
                title: "Football Training",
                activityDescription: "Professional football training for students of all skill levels. Develop teamwork, fitness, and sportsmanship.",
                category: "Sports",
                schedule: "Mon, Wed, Fri 4:00-6:00 PM",
                location: "School Sports Ground"
            ),
            Activity(
                title: "Art Club",
                activityDescription: "Explore various art forms including painting, sketching, and sculpture. Express your creativity and learn from experienced artists.",
                category: "Arts",
                schedule: "Tue, Thu 3:30-5:30 PM",
                location: "Art Studio, Building A"
            ),
            Activity(
                title: "Science Fair",
                activityDescription: "Annual science fair where students showcase innovative projects and experiments. Compete for prizes and recognition.",
                category: "Academic",
                schedule: "March 15-17, All Day",
                location: "Main Auditorium"
            ),
            Activity(
                title: "Cultural Festival",
                activityDescription: "Celebrate diversity through music, dance, and traditional performances from various cultures.",
                category: "Cultural",
                schedule: "Every Semester",
                location: "School Campus"
            )
        ]
        
        activities.forEach { modelContext.insert($0) }
    }
    
    static func createSampleNews(modelContext: ModelContext) {
        let newsArticles = [
            NewsArticle(
                title: "School Wins National Science Competition",
                content: "Our students brought home the first prize in the National Science Competition held last week. The team's innovative project on renewable energy impressed the judges and demonstrated excellence in scientific research. This achievement reflects the dedication of our students and the quality of our science program.",
                author: "Admin Team",
                publishedDate: Date().addingTimeInterval(-86400 * 7),
                category: "Academic"
            ),
            NewsArticle(
                title: "New Sports Facilities Inaugurated",
                content: "We are excited to announce the opening of our new state-of-the-art sports facilities, including an Olympic-size swimming pool, indoor basketball court, and modern gymnasium. These facilities will provide our students with world-class training opportunities.",
                author: "Sports Department",
                publishedDate: Date().addingTimeInterval(-86400 * 3),
                category: "Sports"
            ),
            NewsArticle(
                title: "Annual Day Celebration 2025",
                content: "Join us for our Annual Day celebration featuring performances by students, awards ceremony, and cultural programs. The event will showcase the talents and achievements of our students throughout the year. Parents and guests are warmly invited.",
                author: "Events Committee",
                publishedDate: Date().addingTimeInterval(-86400 * 1),
                category: "Events"
            )
        ]
        
        newsArticles.forEach { modelContext.insert($0) }
    }
    
    static func createSampleCareers(modelContext: ModelContext) {
        let careers = [
            Career(
                jobTitle: "Mathematics Teacher",
                department: "Academic",
                location: "Binnazhara School",
                jobType: "Full-time",
                jobDescription: "We are looking for an experienced Mathematics teacher to join our academic team. The ideal candidate will have a passion for teaching and ability to inspire students.",
                requirements: [
                    "Bachelor's degree in Mathematics or Education",
                    "Minimum 3 years teaching experience",
                    "Strong communication skills",
                    "Ability to use technology in teaching"
                ],
                salary: "$45,000 - $60,000",
                postedDate: Date().addingTimeInterval(-86400 * 14)
            ),
            Career(
                jobTitle: "School Administrator",
                department: "Administration",
                location: "Al Noor School",
                jobType: "Full-time",
                jobDescription: "Seeking a dedicated school administrator to manage daily operations, coordinate with staff, and ensure smooth functioning of school activities.",
                requirements: [
                    "Master's degree in Education Administration",
                    "5+ years in school management",
                    "Leadership and organizational skills",
                    "Experience with school management systems"
                ],
                salary: "$55,000 - $75,000",
                postedDate: Date().addingTimeInterval(-86400 * 10)
            ),
            Career(
                jobTitle: "Sports Coach",
                department: "Physical Education",
                location: "International School",
                jobType: "Part-time",
                jobDescription: "Part-time sports coach needed for afternoon training sessions. Focus on football and athletics training for middle and high school students.",
                requirements: [
                    "Coaching certification",
                    "Experience with youth sports",
                    "First aid certified",
                    "Excellent interpersonal skills"
                ],
                salary: "$25,000 - $35,000",
                postedDate: Date().addingTimeInterval(-86400 * 5)
            )
        ]
        
        careers.forEach { modelContext.insert($0) }
    }
    
    static func populateAllSampleData(modelContext: ModelContext) {
        createSampleSchools(modelContext: modelContext)
        createSampleTeachers(modelContext: modelContext)
        createSamplePrograms(modelContext: modelContext)
        createSampleActivities(modelContext: modelContext)
        createSampleNews(modelContext: modelContext)
        createSampleCareers(modelContext: modelContext)
        
        do {
            try modelContext.save()
        } catch {
            print("Failed to save sample data: \(error)")
        }
    }
}
