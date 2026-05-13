import 'package:web/web.dart' as web;

// Dart Grade Calculator
//
// DATA TYPES: String, double, int, bool, List<String>
// OPERATORS: =, /, *, +, -, %, >, <, >=, <=, ==, !=, &&, ||, !
// CONTROL STRUCTURES: if-else, for loop, while loop
// SUBPROGRAMS: 8 functions with parameters and return values

/// Stores completed grade records as formatted strings.
final List<String> gradeLedger = <String>[];

// ---- SUBPROGRAMS ----
/// Computes the raw term grade: (quiz score / total x 40) + (exam score / total x 60)
double computeRawGrade(
  double quizScore,
  double quizTotal,
  double examScore,
  double examTotal,
) {
  final double quizPercentage = (quizScore / quizTotal) * 40.0;
  final double examPercentage = (examScore / examTotal) * 60.0;
  final double result = quizPercentage + examPercentage;
  return result;
}

/// Computes the final term grade. For Prelims: raw grade only.
/// For Midterms/Finals: (prev x 1/3) + (raw x 2/3).
double computeTermGrade(double rawGrade, double? prevGrade, bool hasPrev) {
  if (!hasPrev || prevGrade == null) {
    return rawGrade;
  } else {
    return (prevGrade * (1.0 / 3.0)) + (rawGrade * (2.0 / 3.0));
  }
}

/// Returns letter grade based on numeric average.
String getLetterGrade(double average) {
  if (average >= 90.0) {
    return 'A';
  } else if (average >= 80.0) {
    return 'B';
  } else if (average >= 70.0) {
    return 'C';
  } else if (average >= 60.0) {
    return 'D';
  } else {
    return 'F';
  }
}

/// Returns true if average is 60 or above.
bool isStudentPassing(double average) {
  return average >= 60.0;
}

/// Builds a formatted grade report string.
String buildResultString({
  required String studentName,
  required String term,
  required double quizScore,
  required double quizTotal,
  required double examScore,
  required double examTotal,
  required double rawGrade,
  required double termGrade,
  required double? prevGrade,
  required String letterGrade,
  required bool passing,
  int computationCount = 0,
}) {
  final String remark;
  if (passing && letterGrade == 'A') {
    remark = 'Excellent performance!';
  } else if (passing && (letterGrade == 'B' || letterGrade == 'C')) {
    remark = 'Keep up the good work.';
  } else if (passing && letterGrade == 'D') {
    remark = 'Needs improvement.';
  } else if (!passing && termGrade > 0) {
    remark = 'Failed.';
  } else {
    remark = 'No valid grades entered.';
  }

  final StringBuffer sb = StringBuffer();
  sb.writeln('----------------------------------------');
  sb.writeln('  STUDENT GRADE REPORT');
  sb.writeln('----------------------------------------');
  sb.writeln('');
  sb.writeln('  Student:       $studentName');
  sb.writeln('  Term:          ${term.toUpperCase()}');
  sb.writeln('');
  sb.writeln('  -- Score Breakdown --');
  sb.writeln(
    '  Quiz:          ${quizScore.toStringAsFixed(1)} / ${quizTotal.toStringAsFixed(1)}',
  );
  sb.writeln(
    '  Exam:          ${examScore.toStringAsFixed(1)} / ${examTotal.toStringAsFixed(1)}',
  );
  sb.writeln('');
  sb.writeln('  -- Computation --');
  sb.writeln(
    '  Quiz (40%):    ${((quizScore / quizTotal) * 100).toStringAsFixed(1)}% x 0.40 = ${((quizScore / quizTotal) * 40.0).toStringAsFixed(2)}',
  );
  sb.writeln(
    '  Exam (60%):    ${((examScore / examTotal) * 100).toStringAsFixed(1)}% x 0.60 = ${((examScore / examTotal) * 60.0).toStringAsFixed(2)}',
  );
  sb.writeln('  Raw Grade:     ${rawGrade.toStringAsFixed(2)}');
  if (prevGrade != null) {
    sb.writeln(
      '  Prev Term:     ${prevGrade.toStringAsFixed(2)} x 1/3 = ${(prevGrade / 3.0).toStringAsFixed(2)}',
    );
    sb.writeln(
      '  Current:       ${rawGrade.toStringAsFixed(2)} x 2/3 = ${(rawGrade * 2.0 / 3.0).toStringAsFixed(2)}',
    );
  }
  sb.writeln('');
  sb.writeln('  -- Result --');
  sb.writeln('  Term Grade:    ${termGrade.toStringAsFixed(2)}');
  sb.writeln('  Letter Grade:  $letterGrade');
  sb.writeln('  Status:        ${passing ? 'PASSED' : 'FAILED'}');
  sb.writeln('  Remark:        $remark');
  if (computationCount > 1) {
    sb.writeln('  Computed:      ${computationCount} time(s)');
  }
  sb.writeln('----------------------------------------');

  return sb.toString();
}

/// Adds a record to the grade ledger.
void addToLedger(String record) {
  gradeLedger.add(record);
}

/// Generates a summary of all computed grades (uses for loop to iterate through ledger).
String buildLedgerSummary() {
  if (gradeLedger.isEmpty) {
    return 'No records in the ledger yet.';
  }

  final StringBuffer sb = StringBuffer();
  sb.writeln('Total Students Computed: ${gradeLedger.length}');
  sb.writeln('');

  for (int i = 0; i < gradeLedger.length; i++) {
    // for loop
    final String entry = gradeLedger[i]; // assignment

    final List<String> lines = entry.split('\n');
    final String nameLine = lines.firstWhere(
      (line) => line.contains('Student:'),
      orElse: () => '  Entry #${i + 1}',
    );
    final String termLine = lines.firstWhere(
      (line) => line.contains('Term:'),
      orElse: () => '',
    );

    final String separator = (i % 2 == 0) ? ' ' : ' '; // modulo
    sb.writeln('${i + 1}.$separator${nameLine.trim()}  |  ${termLine.trim()}');
  }

  sb.writeln('');
  sb.writeln('');

  return sb.toString();
}

/// Validates a numeric input. Returns null if invalid.
double? validateNumericInput(String value, {bool allowZero = false}) {
  final double? parsed = double.tryParse(value);

  if (parsed == null) {
    return null;
  }
  if (parsed < 0.0) {
    return null;
  }
  if (!allowZero && parsed == 0.0) {
    return null;
  }

  return parsed;
}

// ---- MAIN ----

void main() {
  // Get DOM element references
  final web.HTMLInputElement nameInput =
      web.document.querySelector('#student-name') as web.HTMLInputElement;
  final web.HTMLSelectElement termSelect =
      web.document.querySelector('#term-select') as web.HTMLSelectElement;
  final web.HTMLDivElement prevGradeGroup =
      web.document.querySelector('#prev-grade-group') as web.HTMLDivElement;
  final web.HTMLInputElement prevGradeInput =
      web.document.querySelector('#prev-grade') as web.HTMLInputElement;
  final web.HTMLInputElement quizScoreInput =
      web.document.querySelector('#quiz-score') as web.HTMLInputElement;
  final web.HTMLInputElement quizTotalInput =
      web.document.querySelector('#quiz-total') as web.HTMLInputElement;
  final web.HTMLInputElement examScoreInput =
      web.document.querySelector('#exam-score') as web.HTMLInputElement;
  final web.HTMLInputElement examTotalInput =
      web.document.querySelector('#exam-total') as web.HTMLInputElement;
  final web.HTMLDivElement resultCard =
      web.document.querySelector('#result-card') as web.HTMLDivElement;
  final web.HTMLDivElement resultContent =
      web.document.querySelector('#result-content') as web.HTMLDivElement;
  final web.HTMLDivElement ledgerCard =
      web.document.querySelector('#ledger-card') as web.HTMLDivElement;
  final web.HTMLDivElement ledgerContent =
      web.document.querySelector('#ledger-content') as web.HTMLDivElement;
  final web.HTMLDivElement errorMsg =
      web.document.querySelector('#error-msg') as web.HTMLDivElement;
  final web.HTMLButtonElement computeBtn =
      web.document.querySelector('#compute-btn') as web.HTMLButtonElement;
  final web.HTMLButtonElement resetBtn =
      web.document.querySelector('#reset-btn') as web.HTMLButtonElement;

  // Show/hide previous term grade input based on term selection
  termSelect.onChange.listen((web.Event event) {
    final String selectedTerm = termSelect.value; // assignment
    final bool hasPreviousTerm = (selectedTerm != 'prelims'); // relational
    prevGradeGroup.style.display = hasPreviousTerm ? 'block' : 'none';
  });

  prevGradeGroup.style.display = termSelect.value == 'prelims'
      ? 'none'
      : 'block';

  // Compute grade button logic
  computeBtn.onClick.listen((web.MouseEvent event) {
    errorMsg.textContent = '';
    errorMsg.style.display = 'none';

    // Read inputs (Data Types: String, double, bool)
    final String studentName = nameInput.value.trim(); // String
    if (studentName.isEmpty) {
      errorMsg.textContent = 'Please enter a student name.'; // relational
      errorMsg.style.display = 'block';
      return;
    }

    final String term = termSelect.value; // String
    final bool hasPreviousTerm = (term != 'prelims'); // bool

    final double? quizScore = validateNumericInput(quizScoreInput.value);
    final double? quizTotal = validateNumericInput(
      quizTotalInput.value,
      allowZero: false,
    );
    final double? examScore = validateNumericInput(examScoreInput.value);
    final double? examTotal = validateNumericInput(
      examTotalInput.value,
      allowZero: false,
    );

    if (quizScore == null ||
        quizTotal == null ||
        examScore == null ||
        examTotal == null) {
      errorMsg.textContent =
          'Please enter valid positive numbers for all score fields.';
      errorMsg.style.display = 'block';
      return;
    }

    if (quizScore > quizTotal) {
      // relational
      errorMsg.textContent = 'Quiz score cannot exceed the total items.';
      errorMsg.style.display = 'block';
      return;
    }
    if (examScore > examTotal) {
      errorMsg.textContent = 'Exam score cannot exceed the total items.';
      errorMsg.style.display = 'block';
      return;
    }

    double? prevGrade; // double
    if (hasPreviousTerm) {
      prevGrade = validateNumericInput(prevGradeInput.value);
      if (prevGrade == null || prevGrade < 0.0 || prevGrade > 100.0) {
        errorMsg.textContent =
            'Please enter a valid previous term grade between 0 and 100.';
        errorMsg.style.display = 'block';
        return;
      }
    }

    // Compute grade using subprograms
    final double rawGrade = computeRawGrade(
      quizScore,
      quizTotal,
      examScore,
      examTotal,
    );
    final double termGrade = computeTermGrade(
      rawGrade,
      prevGrade,
      hasPreviousTerm,
    );
    final String letterGrade = getLetterGrade(termGrade);
    final bool passing = isStudentPassing(termGrade);

    final String result = buildResultString(
      studentName: studentName,
      term: term,
      quizScore: quizScore,
      quizTotal: quizTotal,
      examScore: examScore,
      examTotal: examTotal,
      rawGrade: rawGrade,
      termGrade: termGrade,
      prevGrade: prevGrade,
      letterGrade: letterGrade,
      passing: passing,
    );

    resultContent.textContent = result;
    resultCard.style.display = 'block';

    addToLedger(result);

    // Count how many times this student has been computed (while loop)
    int computationCount = 0;
    int searchIndex = 0;
    while (searchIndex < gradeLedger.length) {
      if (gradeLedger[searchIndex].contains('Student: $studentName')) {
        computationCount++;
      }
      searchIndex++;
    }

    // Update result with computation count if computed more than once
    if (computationCount > 1) {
      final String resultWithCount = buildResultString(
        studentName: studentName,
        term: term,
        quizScore: quizScore,
        quizTotal: quizTotal,
        examScore: examScore,
        examTotal: examTotal,
        rawGrade: rawGrade,
        termGrade: termGrade,
        prevGrade: prevGrade,
        letterGrade: letterGrade,
        passing: passing,
        computationCount: computationCount,
      );
      resultContent.textContent = resultWithCount;
    }

    ledgerContent.textContent = buildLedgerSummary();
    ledgerCard.style.display = 'block';
  });

  // Reset button logic
  resetBtn.onClick.listen((web.MouseEvent event) {
    nameInput.value = '';
    termSelect.value = 'prelims';
    prevGradeGroup.style.display = 'none';
    prevGradeInput.value = '';
    quizScoreInput.value = ' ';
    quizTotalInput.value = ' ';
    examScoreInput.value = ' ';
    examTotalInput.value = ' ';

    resultCard.style.display = 'none';
    ledgerCard.style.display = 'none';
    errorMsg.style.display = 'none';
    resultContent.textContent = '';
    ledgerContent.textContent = '';
  });
}
