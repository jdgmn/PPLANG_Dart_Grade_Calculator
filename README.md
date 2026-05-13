# Dart Grade Calculator

A Dart web application that computes student term grades based on a school grading system. Built as a principles of programming languages project.

## Features

- Compute term grades for **Prelims**, **Midterms**, or **Finals**
- Quiz score contributes **40%**, exam score contributes **60%** of the raw grade
- Handles varying score totals (quizzes and exams can be over different total items)
- For **Midterms** and **Finals**: previous term grade is weighted at **1/3**, current raw grade at **2/3**
- Determines letter grade (A, B, C, D, F) and pass/fail status
- Maintains a **Grade Ledger** to track all computed students in a session
- Input validation with error messages

## Grading Formula

```
Prelims:
  Raw Grade = (Quiz Score / Quiz Total x 40) + (Exam Score / Exam Total x 60)
  Term Grade = Raw Grade

Midterms / Finals:
  Raw Grade = (Quiz Score / Quiz Total x 40) + (Exam Score / Exam Total x 60)
  Term Grade = (Previous Term Grade x 1/3) + (Raw Grade x 2/3)
```

## How to Run

### Prerequisites
- [Dart SDK](https://dart.dev/get-dart) (version 3.11.4 or later)

### Steps

1. Clone the repository:
   ```bash
   git clone <repo-url>
   cd pplang_dart_web
   ```

2. Start the development server:
   ```bash
   dart run build_runner serve
   ```

3. Open your browser and go to:
   ```
   http://localhost:8080
   ```

4. Enter student details, select a term, input scores, and click **Compute Grade**.

## Project Structure

```
pplang_dart_web/
├── web/
│   ├── index.html      # HTML structure and form
│   ├── main.dart       # Dart application logic
│   └── styles.css      # Styling
├── pubspec.yaml        # Dart project configuration
└── README.md           # This file
```

## Concepts Demonstrated

- **Data Types**: String, double, int, bool, List<String>
- **Operators**: Assignment (=), Arithmetic (+, -, *, /, %), Relational (==, !=, <, >, <=, >=), Logical (&&, \|\|, !)
- **Control Structures**: Selection (if-else), Iteration (for loop, while loop)
- **Subprograms**: 7 functions including parameterized functions and return values

## Built With

- [Dart](https://dart.dev/) - Programming language
- [package:web](https://pub.dev/packages/web) - Web interop library
- [build_runner](https://pub.dev/packages/build_runner) - Build system