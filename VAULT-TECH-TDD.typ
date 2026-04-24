// ============================================================
// VAULT-TECH -- Technical Design Document
// Typst source -- compile with: typst compile VAULT-TECH-TDD.typ
// ============================================================

#let brand-blue   = rgb("#1A237E")
#let brand-gold   = rgb("#F9A825")
#let light-gray   = rgb("#F5F5F5")
#let med-gray     = rgb("#9E9E9E")
#let dark-gray    = rgb("#424242")
#let success-green = rgb("#2E7D32")
#let warning-red  = rgb("#C62828")
#let warn-yellow  = rgb("#E65100")
#let warn-bg      = rgb("#FFF8E1")
#let info-bg      = rgb("#E8EAF6")
#let code-bg      = rgb("#1A1A2E")
#let code-text    = rgb("#D8D8D8")
#let code-gold    = rgb("#F9A825")
#let code-blue    = rgb("#A8D8EA")

// ── Page setup ───────────────────────────────────────────────
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  header: context {
    if counter(page).get().first() > 1 [
      #set text(font: "Cambria", size: 9pt, fill: med-gray)
      #grid(
        columns: (1fr, auto),
        [VAULT-TECH -- Technical Design Document],
        align(right)[#counter(page).display("1")]
      )
      #line(length: 100%, stroke: 0.5pt + brand-blue)
    ]
  },
  footer: context {
    if counter(page).get().first() > 1 [
      #line(length: 100%, stroke: 0.5pt + brand-gold)
      #set text(size: 9pt, fill: med-gray)
      #align(center)[Confidential -- For Academic Use Only]
    ]
  }
)

#set text(font: "Cambria", size: 9pt, fill: dark-gray)
#set par(justify: true, leading: 0.65em)
#show heading.where(level: 1): it => {
  v(1.2em)
  block(
    width: 100%,
    fill: brand-blue,
    inset: (x: 10pt, y: 7pt),
    radius: 4pt,
    text(fill: white, weight: "bold", size: 13pt, it.body)
  )
  v(0.4em)
}
#show heading.where(level: 2): it => {
  v(0.9em)
  text(fill: brand-blue, weight: "bold", size: 12pt, it.body)
  v(0.1em)
  line(length: 100%, stroke: 1.5pt + brand-gold)
  v(0.3em)
}
#show heading.where(level: 3): it => {
  v(0.6em)
  text(fill: dark-gray, weight: "bold", size: 11pt, it.body)
  v(0.2em)
}

// ── Utility components ────────────────────────────────────────
#let note(label, body, border-color: brand-blue, bg: info-bg) = block(
  width: 100%,
  fill: bg,
  inset: (left: 12pt, right: 10pt, top: 7pt, bottom: 7pt),
  stroke: (left: 3pt + border-color),
  radius: (right: 4pt),
  [#text(weight: "bold", fill: border-color)[#label ]#body]
)

#let gap-note(body) = note("⚠ Design Gap: ", body, border-color: warn-yellow, bg: warn-bg)

#let badge(text-content, color) = box(
  fill: color.lighten(80%),
  stroke: 0.5pt + color,
  inset: (x: 6pt, y: 3pt),
  radius: 3pt,
  text(fill: color, weight: "bold", size: 9pt, text-content)
)

#let status-yes  = badge("COVERED",     success-green)
#let status-no   = badge("MISSING",     warning-red)
#let status-part = badge("PARTIAL",     warn-yellow)
#let status-nd   = badge("NOT DESIGNED",med-gray)

#let code-block(body) = block(
  width: 100%,
  fill: code-bg,
  inset: 10pt,
  radius: 4pt,
  text(font: "Courier New", size: 8.5pt, fill: code-text, body)
)

#let th(content) = table.cell(fill: brand-blue, text(fill: white, weight: "bold", size: 9.5pt, content))
#let td(content, shade: white) = table.cell(fill: shade, text(size: 9.5pt, content))
#let tda(content, shade: white) = table.cell(fill: shade, align: center, text(size: 9.5pt, content))

// ── COVER PAGE ───────────────────────────────────────────────
#page(
  margin: (top: 4cm, bottom: 3cm, left: 3cm, right: 3cm),
  header: none,
  footer: none,
)[
  #align(center)[
    #v(3cm)
    #block(
      width: 100%,
      fill: brand-blue,
      inset: (x: 20pt, y: 30pt),
      radius: 8pt,
    )[
      #text(fill: white, weight: "bold", size: 38pt)[VAULT-TECH]
      #v(0.2em)
      #text(fill: brand-gold, size: 18pt)[Personal Budgeting App]
    ]
    #v(1.5cm)
    #line(length: 80%, stroke: 2pt + brand-gold)
    #v(1cm)
    #text(weight: "bold", size: 20pt, fill: dark-gray)[TECHNICAL DESIGN DOCUMENT]
    #v(0.4em)
    #text(size: 13pt, fill: med-gray)[High-Definition Android Prototype]
    #v(0.6em)
    #text(size: 11pt, fill: med-gray)[Kotlin · Android · RoomDB · MVVM]
    #v(3cm)
    #grid(
      columns: (1fr, 1fr, 1fr),
      gutter: 1em,
      block(fill: light-gray, inset: 10pt, radius: 4pt)[
        #text(size: 8pt, fill: med-gray)[Version]
        #linebreak()
        #text(weight: "bold", size: 10pt)[1.0]
      ],
      block(fill: light-gray, inset: 10pt, radius: 4pt)[
        #text(size: 8pt, fill: med-gray)[Year]
        #linebreak()
        #text(weight: "bold", size: 10pt)[2025]
      ],
      block(fill: light-gray, inset: 10pt, radius: 4pt)[
        #text(size: 8pt, fill: med-gray)[Platform]
        #linebreak()
        #text(weight: "bold", size: 10pt)[Android]
      ],
    )
  ]
]

// ── SECTION 1: DESIGN ALIGNMENT ──────────────────────────────
= 1. Design Alignment Analysis

This section evaluates how the Part 1 wireframe design aligns with the assignment requirements. Where gaps exist, this document details the additional screens and components required for full compliance.

== 1.1 Alignment Matrix

#table(
  columns: (2fr, 1.1fr, 2fr),
  inset: (x: 8pt, y: 6pt),
  stroke: 0.5pt + rgb("#DDDDDD"),
  th[Requirement], th[Status], th[Notes],
  td[Login with username & password], tda[#status-yes], td[Login page exists in wireframe],
  td[Create expense categories],      tda[#status-yes], td[Add Category button shown],
  td[Expense entry: date],            tda[#status-yes], td[Date field on Add Expense page],
  td[Expense entry: *start & end times*], tda[#status-no], td[Not designed -- must be added],
  td[Expense entry: *description*],   tda[#status-no], td[No description/notes field -- must be added],
  td[Expense entry: category],        tda[#status-yes], td[Category selection present],
  td[*Optional photo per expense*],   tda[#status-no], td[Not designed -- new component required],
  td[*Min & max monthly goals*],      tda[#status-part], td[Only a single budget amount; two-field goal screen needed],
  td[*View expense list by period*],  tda[#status-part], td[Chart view only; no scrollable list with filter],
  td[*View photo from expense list*], tda[#status-no], td[Depends on photo feature; new detail screen needed],
  td[*Total per category / period*],  tda[#status-part], td[Pie chart partial; dedicated filter+totals view needed],
  td[*Local RoomDB persistence*],     tda[#status-nd], td[No data layer designed -- full architecture required],
  td[Invalid input / no crashes],     tda[#status-nd], td[Must be implemented entirely in Kotlin logic],
)

#v(0.5em)
#note("Legend: ", [
  #badge("COVERED", success-green) Fully addressed by Part 1 design · 
  #badge("PARTIAL", warn-yellow) Partially covered, needs extension · 
  #badge("MISSING", warning-red) New screen/component required
])

== 1.2 Additional Screens Required

The following screens must be added to the original design to satisfy all requirements:

- *Add Expense (Extended)* -- add start time, end time, description, and optional photo fields
- *Expense List Screen* -- scrollable RecyclerView list, filterable by date range, with photo access
- *Expense Detail Screen* -- full detail view including photo display
- *Budget Goals Screen* -- set minimum and maximum monthly spending goals
- *Category Totals Screen* -- total spend per category for a user-selectable period

#pagebreak()

// ── SECTION 2: ARCHITECTURE ───────────────────────────────────
= 2. Architecture Overview

== 2.1 Design Pattern: MVVM

The app follows the Model-View-ViewModel (MVVM) pattern using Android Architecture Components -- the recommended approach for modern Android development.

#table(
  columns: (1fr, 1.6fr, 2fr),
  inset: (x: 8pt, y: 6pt),
  stroke: 0.5pt + rgb("#DDDDDD"),
  th[Layer], th[Components], th[Responsibility],
  td[*View*], td[Activities, Fragments, XML layouts], td[Display data; capture input; observe LiveData],
  td[*ViewModel*], td[ExpenseViewModel, CategoryViewModel...], td[Hold UI state; call Repository; expose LiveData],
  td[*Repository*], td[ExpenseRepository, CategoryRepository], td[Single source of truth; abstracts RoomDB from ViewModels],
  td[*Room DB*], td[Entities, DAOs, AppDatabase], td[SQLite persistence via Room ORM],
)

== 2.2 Project Package Structure

#code-block[
  #text(fill: code-blue)[com.vaulttech.app]\
  #text(fill: code-gold)[├── data/]\
  #text(fill: code-gold)[│   ├── db/]\
  #text(fill: code-text)[│   │   ├── AppDatabase.kt]\
  #text(fill: code-text)[│   │   ├── dao/       (UserDao, ExpenseDao, CategoryDao, GoalDao)]\
  #text(fill: code-text)[│   │   └── entity/    (User, Expense, Category, Goal)]\
  #text(fill: code-gold)[│   └── repository/]\
  #text(fill: code-gold)[├── ui/]\
  #text(fill: code-text)[│   ├── auth/          (LoginActivity, SignUpActivity)]\
  #text(fill: code-text)[│   ├── home/          (HomeActivity, HomeFragment)]\
  #text(fill: code-text)[│   ├── expense/       (AddExpenseActivity, ExpenseListActivity, ExpenseDetailActivity)]\
  #text(fill: code-text)[│   ├── category/      (ManageCategoriesActivity)]\
  #text(fill: code-text)[│   ├── goals/         (BudgetGoalsActivity)]\
  #text(fill: code-text)[│   ├── reports/       (CategoryTotalsActivity)]\
  #text(fill: code-text)[│   ├── profile/       (ProfileActivity, EditProfileActivity, AchievementsActivity)]\
  #text(fill: code-text)[│   └── notifications/ (NotificationsActivity)]\
  #text(fill: code-gold)[└── viewmodel/]
]

#pagebreak()

// ── SECTION 3: ROOMDB DATA LAYER ─────────────────────────────
= 3. RoomDB Data Layer

== 3.1 Entity: User

#table(
  columns: (1.2fr, 1fr, 1.1fr, 1.8fr),
  inset: (x: 8pt, y: 6pt),
  stroke: 0.5pt + rgb("#DDDDDD"),
  th[Field], th[Type], th[Constraints], th[Description],
  td[userId],        td[Int],     td[PK, AutoGen],    td[Unique user identifier],
  td[username],      td[String],  td[NOT NULL, UNIQUE],td[Login username],
  td[passwordHash],  td[String],  td[NOT NULL],       td[SHA-256 hashed password],
  td[firstName],     td[String],  td[NOT NULL],       td[User first name],
  td[lastName],      td[String],  td[NOT NULL],       td[User last name],
  td[email],         td[String],  td[NOT NULL],       td[User email address],
  td[dateOfBirth],   td[String],  td[NOT NULL],       td[DOB in yyyy-MM-dd format],
  td[profilePicPath],td[String?], td[NULLABLE],       td[Local URI path to profile image],
)

== 3.2 Entity: Category

#table(
  columns: (1.2fr, 1fr, 1.1fr, 1.8fr),
  inset: (x: 8pt, y: 6pt),
  stroke: 0.5pt + rgb("#DDDDDD"),
  th[Field], th[Type], th[Constraints], th[Description],
  td[categoryId], td[Int],    td[PK, AutoGen],   td[Unique category identifier],
  td[userId],     td[Int],    td[FK → User],     td[Owning user],
  td[name],       td[String], td[NOT NULL],      td[Category name e.g. Food, Petrol],
  td[colourHex],  td[String], td[NOT NULL],      td[Hex colour for pie chart e.g. \#F9A825],
  td[iconRes],    td[String?],td[NULLABLE],      td[Optional drawable resource name],
)

#pagebreak()

== 3.3 Entity: Expense

#gap-note[Original design missing start time, end time, description, and photo. All four fields must be present in this entity.]

#table(
  columns: (1.2fr, 1fr, 1.1fr, 1.8fr),
  inset: (x: 8pt, y: 6pt),
  stroke: 0.5pt + rgb("#DDDDDD"),
  th[Field], th[Type], th[Constraints], th[Description],
  td[expenseId],   td[Int],    td[PK, AutoGen],    td[Unique expense identifier],
  td[userId],      td[Int],    td[FK → User],      td[Owning user],
  td[categoryId],  td[Int],    td[FK → Category],  td[Associated category],
  td[description], td[String], td[NOT NULL],       td[*NEW* -- user description of expense],
  td[amount],      td[Double], td[NOT NULL, > 0],  td[Expense amount in Rands],
  td[date],        td[String], td[NOT NULL],       td[Date in yyyy-MM-dd format],
  td[startTime],   td[String], td[NOT NULL],       td[*NEW* -- start time HH:mm],
  td[endTime],     td[String], td[NOT NULL],       td[*NEW* -- end time HH:mm; must be > startTime],
  td[photoPath],   td[String?],td[NULLABLE],       td[*NEW* -- local file URI path to photo],
)

== 3.4 Entity: Goal

#gap-note[Original design had a single budget amount. The assignment requires both a minimum and maximum monthly goal.]

#table(
  columns: (1.2fr, 1fr, 1.1fr, 1.8fr),
  inset: (x: 8pt, y: 6pt),
  stroke: 0.5pt + rgb("#DDDDDD"),
  th[Field], th[Type], th[Constraints], th[Description],
  td[goalId],     td[Int],    td[PK, AutoGen],        td[Unique goal identifier],
  td[userId],     td[Int],    td[FK → User],          td[Owning user],
  td[categoryId], td[Int?],   td[FK → Category, NULL],td[Null = overall budget goal],
  td[monthYear],  td[String], td[NOT NULL],           td[Target month in yyyy-MM format],
  td[minGoal],    td[Double], td[NOT NULL, ≥ 0],      td[Minimum spending goal (lower bound)],
  td[maxGoal],    td[Double], td[NOT NULL, > minGoal],td[Maximum spending goal (upper bound)],
)

== 3.5 DAO Interfaces

Key methods required per DAO:

- *UserDao:* `insert`, `getUserByUsername(username)`, `updateUser`, `deleteUser`
- *CategoryDao:* `insert`, `getCategoriesByUser(userId)`, `updateCategory`, `deleteCategory`
- *ExpenseDao:* `insert`, `getExpensesByUserAndPeriod(userId, startDate, endDate)`, `getTotalByCategory(userId, categoryId, startDate, endDate)`, `updateExpense`, `deleteExpense`
- *GoalDao:* `insert`, `getGoalsByUser(userId, monthYear)`, `updateGoal`

#pagebreak()

// ── SECTION 4: SCREEN SPECIFICATIONS ─────────────────────────
= 4. Screen Specifications

#let screen-table(rows) = table(
  columns: (1.3fr, 1.5fr, 2fr),
  inset: (x: 8pt, y: 6pt),
  stroke: 0.5pt + rgb("#DDDDDD"),
  th[Component], th[XML Widget], th[Notes],
  ..rows.flatten()
)

== 4.1 Splash / Cover Screen

#screen-table((
  (td[Logo], td[ImageView], td[Centered; load from drawable]),
  (td[App Name], td[TextView], td[Bold; white on royal blue background]),
  (td[Loading indicator], td[ProgressBar (circular)], td[Visible while checking session in SharedPreferences]),
  (td[Auto-navigate], td[Handler.postDelayed], td[After 2 s; check saved userId; route to Login or Home]),
))

== 4.2 Login Screen -- `LoginActivity`

#note("Note: ", "This screen aligns with the Part 1 design. No structural changes needed.")

#screen-table((
  (td[Username],       td[EditText (inputType=text)],     td[Hint: "Enter username"; validate non-empty]),
  (td[Password],       td[EditText (inputType=textPassword)], td[Hint: "Enter password"; validate non-empty]),
  (td[Remember Me],    td[CheckBox],                      td[Saves username to SharedPreferences only]),
  (td[Login Button],   td[Button],                        td[Query UserDao; show Toast on invalid credentials]),
  (td[Sign Up Link],   td[TextView (clickable)],          td[startActivity(Intent → SignUpActivity)]),
))

#pagebreak()

== 4.3 Sign Up Screen -- `SignUpActivity`

#screen-table((
  (td[First Name],        td[EditText],                         td[Validate: letters only, non-empty]),
  (td[Last Name],         td[EditText],                         td[Validate: letters only, non-empty]),
  (td[Username],          td[EditText],                         td[Validate: alphanumeric, 4–20 chars, unique in DB]),
  (td[Email],             td[EditText (inputType=textEmailAddress)], td[Validate with Patterns.EMAIL_ADDRESS]),
  (td[Password],          td[EditText (inputType=textPassword)],td[Min 8 chars, 1 digit, 1 uppercase]),
  (td[Confirm Password],  td[EditText (inputType=textPassword)],td[Must match password field]),
  (td[Date of Birth],     td[EditText + DatePickerDialog],      td[Open picker on focus; must be 13+ years ago]),
  (td[Register Button],   td[Button],                           td[Validate all fields; insert User; navigate to Login]),
))

== 4.4 Home Screen -- `HomeActivity`

#screen-table((
  (td[Pie Chart],         td[MPAndroidChart: PieChart],      td[Spend by category for current month]),
  (td[Total Budget Label],td[TextView],                      td[Pull from GoalDao for current month]),
  (td[Category List],     td[RecyclerView],                  td[Colour dot · category name · amount spent]),
  (td[Add Category FAB],  td[FloatingActionButton],          td[Opens ManageCategoriesActivity]),
  (td[Bottom Navigation], td[BottomNavigationView],          td[Home, Expenses, Reports, Goals, Profile]),
  (td[Notification Bell], td[MenuItem (Toolbar)],            td[Badge count; opens NotificationsActivity]),
  (td[Warning Banner],    td[CardView (GONE by default)],    td[Show red banner if spend > maxGoal]),
))

#pagebreak()

== 4.5 Add Expense Screen -- `AddExpenseActivity`

#gap-note[Start time, end time, description, and photo are all missing from the Part 1 design and must be added.]

#screen-table((
  (td[Category],    td[Spinner / AutoCompleteTextView],        td[Populated from CategoryDao by userId]),
  (td[Description], td[EditText (multiline)],                  td[*NEW* -- min 1 char, max 200 chars]),
  (td[Amount],      td[EditText (inputType=numberDecimal)],    td[Validate > 0; format with NumberFormat.getCurrencyInstance()]),
  (td[Date],        td[EditText + DatePickerDialog],           td[Tap to open picker; store yyyy-MM-dd]),
  (td[Start Time],  td[EditText + TimePickerDialog],           td[*NEW* -- tap to open TimePickerDialog; store HH:mm]),
  (td[End Time],    td[EditText + TimePickerDialog],           td[*NEW* -- validate endTime > startTime]),
  (td[Photo],       td[ImageView + Button],                    td[*NEW* -- camera or gallery intent; thumbnail preview if selected]),
  (td[Save],        td[Button],                                td[Validate all required fields; insert Expense; finish()]),
  (td[Back],        td[Button / Up Navigation],                td[Confirm discard dialog if fields have content]),
))


== 4.6 Expense List Screen -- `ExpenseListActivity`

#gap-note[New screen required. Part 1 showed a chart view only -- no scrollable list with date filter or photo access.]

#screen-table((
  (td[Date Range Filter],  td[Two EditText + DatePickerDialog], td[From-date and to-date; default to current month]),
  (td[Apply Button],       td[Button],                          td[Re-query ExpenseDao.getExpensesByUserAndPeriod()]),
  (td[Expense List],       td[RecyclerView + ExpenseAdapter],   td[Date · category chip · description preview · amount · photo icon]),
  (td[Photo Icon],         td[ImageView in row],                td[Visible only if photoPath ≠ null; tap to open ExpenseDetailActivity]),
  (td[Empty State],        td[TextView or Lottie animation],    td[Shown when no expenses match filter]),
  (td[Add Expense FAB],    td[FloatingActionButton],            td[Launches AddExpenseActivity]),
))

#pagebreak()

== 4.7 Expense Detail Screen -- `ExpenseDetailActivity`

#gap-note[New screen required to display full expense details including photo.]

#screen-table((
  (td[Photo],         td[ImageView (full-width)],    td[Load via Glide or BitmapFactory; GONE if no photo]),
  (td[Category],      td[TextView + Chip],           td[Category name with colour chip]),
  (td[Description],   td[TextView],                  td[Full description text]),
  (td[Amount],        td[TextView],                  td[Formatted with NumberFormat.getCurrencyInstance()]),
  (td[Date & Time],   td[TextView],                  td[date · startTime – endTime]),
  (td[Edit Button],   td[Button],                    td[Re-open AddExpenseActivity pre-populated]),
  (td[Delete Button], td[Button],                    td[AlertDialog confirmation; then ExpenseDao.deleteExpense()]),
))

== 4.8 Budget Goals Screen -- `BudgetGoalsActivity`

#gap-note[Original design had a single budget amount. Two fields (min and max) are explicitly required by the assignment.]

#screen-table((
  (td[Month Selector], td[Spinner (month/year)],                  td[Defaults to current month]),
  (td[Category],       td[Spinner],                               td[Optional; null = overall goal]),
  (td[Minimum Goal],   td[EditText (inputType=numberDecimal)],    td[Validate ≥ 0; display with NumberFormat]),
  (td[Maximum Goal],   td[EditText (inputType=numberDecimal)],    td[Validate > minGoal]),
  (td[SeekBar],        td[SeekBar],                               td[Range 0–100 000; syncs bidirectionally with MaxGoal EditText]),
  (td[Save Button],    td[Button],                                td[Upsert Goal entity; navigate back]),
  (td[Progress Card],  td[CardView + ProgressBar],                td[Current spend vs. min/max range for selected month]),
))

#pagebreak()

== 4.9 Category Totals Screen -- `CategoryTotalsActivity`

#gap-note[New screen required for structured period-based totals per category.]

#screen-table((
  (td[Date Range],      td[Two EditText + DatePickerDialog], td[From/to date selectors]),
  (td[Apply Button],    td[Button],                          td[Re-query ExpenseDao.getTotalByCategory()]),
  (td[Bar Chart],       td[MPAndroidChart: BarChart],        td[X-axis = categories; Y-axis = total amount spent]),
  (td[Totals Table],    td[RecyclerView],                    td[Category · total · % of budget · over/under indicator]),
  (td[Goal Indicators], td[ProgressBar per row],             td[Green = within range; Red = over max goal]),
))

== 4.10 Profile & Achievements Screens

#note("Note: ", "These screens align with Part 1. Minor additions only.")

#screen-table((
  (td[Profile Picture],   td[ImageView (circular)],  td[Load from profilePicPath; fallback to default avatar]),
  (td[Username],          td[TextView],              td[Read from SharedPreferences session]),
  (td[Edit Profile],      td[Button],                td[Navigate to EditProfileActivity]),
  (td[Achievements],      td[Button],                td[Navigate to AchievementsActivity]),
  (td[Sign Out],          td[Button],                td[Clear SharedPreferences; startActivity(Login); finishAffinity()]),
  (td[Achievement Badges],td[RecyclerView],          td[6 badges: Category Creator, Goal Crusher, On Track, Budget Builder, Income Tracker, Penny Saver]),
  (td[Level Indicator],   td[TextView + ProgressBar],td[Level derived from count of unlocked achievements]),
))

#pagebreak()

// ── SECTION 5: IMPLEMENTATION DETAILS ────────────────────────
= 5. Key Implementation Details

== 5.1 Photo Capture & Storage

- Use `FileProvider` to create a temporary image URI for the camera intent
- Register `ActivityResultLauncher` for both `ACTION_IMAGE_CAPTURE` (camera) and `ACTION_PICK` (gallery)
- Compress the captured bitmap before saving: `Bitmap.compress(JPEG, 80, outputStream)`
- Store only the local *file path* (String) in the Expense entity -- never the full bitmap
- Load images in `ExpenseDetailActivity` using Glide or `BitmapFactory.decodeFile()` for memory safety

== 5.2 Input Validation Strategy

- Validate *all* fields before any database write operation
- Use `editText.error = "message"` for inline field-level feedback (not Toast alone)
- Attach `TextWatcher` on amount fields to format currency as the user types
- `DatePickerDialog`: set minimum date = today for expense dates; set maximum date = 13 years ago for DOB
- `TimePickerDialog`: validate endTime > startTime on Save button press
- Wrap all RoomDB calls in try-catch; log with `Log.e("VAULT-TECH", ...)`

== 5.3 SharedPreferences -- Session Management

- On successful login: save `userId` and `username` to SharedPreferences
- Splash screen reads saved `userId`; if present, skip Login and route directly to Home
- Sign Out: clear all SharedPreferences keys; call `finishAffinity()`
- Remember Me: saves *username only* -- never save passwords in SharedPreferences

== 5.4 Navigation Flow

- *Login → Home:* use `FLAG_ACTIVITY_NEW_TASK | FLAG_ACTIVITY_CLEAR_TOP` to clear the auth back stack
- *Home → sub-screens:* standard `startActivity()`; sub-screens call `finish()` to return
- `AddExpenseActivity` can be launched from: Home FAB, Expense List FAB, or Edit button in ExpenseDetail
- Pass `expenseId` as an Intent extra when editing; a value of `–1` means a new expense

== 5.5 MPAndroidChart Integration

- Add dependency: `implementation 'com.github.PhilJay:MPAndroidChart:v3.1.0'`
- Add JitPack to `settings.gradle`: `maven { url 'https://jitpack.io' }`
- *PieChart (Home):* one `PieEntry` per category; colour list from `Category.colourHex`
- *BarChart (Category Totals):* one `BarEntry` per category; data from DAO totals queries
- Refresh charts by calling `chart.notifyDataSetChanged()` then `chart.invalidate()`

#pagebreak()

// ── SECTION 6: GITHUB ACTIONS & CI/CD ────────────────────────
= 6. GitHub Actions & CI/CD

== 6.1 Repository Setup

- Initialise with a `README.md` including: project description, setup steps, APK link, and YouTube video link
- Create `.gitignore` using Android Studio's default Android template
- Commit and push after completing each major feature -- minimum one commit per screen
- Use descriptive commit messages: e.g. `feat: add expense list screen with date filter`

== 6.2 GitHub Actions Workflow

Create `.github/workflows/build.yml`:

#code-block[
  #text(fill: code-gold)[name: Android Build & Test]\
  #text(fill: code-text)[on: \[push, pull_request\]]\
  \ \
  #text(fill: code-blue)[jobs:]\
  #text(fill: code-text)[  build:]\
  #text(fill: code-text)[    runs-on: ubuntu-latest]\
  #text(fill: code-blue)[    steps:]\
  #text(fill: code-text)[      - uses: actions/checkout\@v3]\
  #text(fill: code-text)[      - uses: actions/setup-java\@v3]\
  #text(fill: code-text)[        with:]\
  #text(fill: code-text)[          distribution: temurin]\
  #text(fill: code-text)[          java-version: 17]\
  #text(fill: code-gold)[      - name: Build Debug APK]\
  #text(fill: code-text)[        run: ./gradlew assembleDebug]\
  #text(fill: code-gold)[      - name: Run Unit Tests]\
  #text(fill: code-text)[        run: ./gradlew test]\
  #text(fill: code-gold)[      - name: Upload APK Artifact]\
  #text(fill: code-text)[        uses: actions/upload-artifact\@v3]\
  #text(fill: code-text)[        with:]\
  #text(fill: code-text)[          name: app-debug]\
  #text(fill: code-text)[          path: app/build/outputs/apk/debug/app-debug.apk]
]

== 6.3 Automated Testing Requirements

- *Unit tests* (`test/` folder): ViewModel logic, Repository methods, input validation utilities
- *Instrumented tests* (`androidTest/`): RoomDB DAO queries using an *in-memory* database
- Minimum coverage: `UserDao` insert/query, `ExpenseDao` period filter, validation utility functions
- Use `@RunWith(AndroidJUnit4::class)` for all instrumented tests
- Use MockK or Mockito for mocking LiveData and Repository in ViewModel unit tests

#pagebreak()

// ── SECTION 7: COLOUR & BRANDING ─────────────────────────────
= 7. Colour System & Branding

== 7.1 Colour Palette

#table(
  columns: (1.4fr, 1fr, 2fr),
  inset: (x: 8pt, y: 6pt),
  stroke: 0.5pt + rgb("#DDDDDD"),
  th[Token], th[Hex Value], th[Usage],
  td[brand_blue],      td[\#1A237E], td[Primary: toolbars, headings, buttons, table headers],
  td[brand_gold],      td[\#F9A825], td[Accent: FABs, dividers, chart highlight],
  td[background_light],td[\#F5F5F5], td[Screen backgrounds, alternating table rows],
  td[surface_white],   td[\#FFFFFF], td[Cards, dialogs, input fields],
  td[text_primary],    td[\#424242], td[Body text, labels],
  td[success_green],   td[\#2E7D32], td[Within-budget indicators, success states],
  td[warning_red],     td[\#C62828], td[Over-budget warnings, error states],
)

== 7.2 Typography & Spacing

*Font:* Roboto (Android default -- no import required)

#table(
  columns: (1.4fr, 1fr, 1fr, 2fr),
  inset: (x: 8pt, y: 6pt),
  stroke: 0.5pt + rgb("#DDDDDD"),
  th[Use], th[Weight], th[Size], th[Example],
  td[App name / display], td[Bold],   td[28sp+],td[VAULT-TECH header],
  td[Section headers],    td[Medium], td[18sp], td[Screen titles],
  td[Body text],          td[Regular],td[14sp], td[Labels, descriptions],
  td[Captions],           td[Light],  td[12sp], td[Dates, metadata],
  td[Currency amounts],   td[Bold],   td[16sp], td[R 4 200.00 in brand_blue],
)

*Spacing standards:*
- Screen padding: 16 dp horizontal · 12 dp vertical
- Card elevation: 4 dp
- RecyclerView item spacing: 8 dp
- Minimum touch target: 48 dp height
- Input field corner radius: 8 dp (use `MaterialTextInputLayout`)
- Base theme: `Theme.Material3.DayNight.NoActionBar`

#pagebreak()

// ── SECTION 8: SUBMISSION CHECKLIST ──────────────────────────
= 8. Submission Checklist

#table(
  columns: (5fr, 0.8fr, 0.8fr),
  inset: (x: 8pt, y: 7pt),
  stroke: 0.5pt + rgb("#DDDDDD"),
  th[Deliverable], th[Required], th[Done],
  td[Kotlin source code on GitHub (no zip files)],             tda[#badge("✓", success-green)], tda[☐],
  td[README with video link and project setup instructions],   tda[#badge("✓", success-green)], tda[☐],
  td[Video demo with voiceover (YouTube unlisted)],            tda[#badge("✓", success-green)], tda[☐],
  td[Built debug APK uploaded],                                tda[#badge("✓", success-green)], tda[☐],
  td[GitHub Actions build.yml configured and passing],         tda[#badge("✓", success-green)], tda[☐],
  td[Unit tests and instrumented tests written],               tda[#badge("✓", success-green)], tda[☐],
  td[Code comments and source references throughout],          tda[#badge("✓", success-green)], tda[☐],
  td[Logging (Log.d / Log.e) used for key operations],         tda[#badge("✓", success-green)], tda[☐],
  td[App handles all invalid inputs without crashing],         tda[#badge("✓", success-green)], tda[☐],
  td[All data persisted to RoomDB (no hardcoded data)],        tda[#badge("✓", success-green)], tda[☐],
  td[All 4 missing fields added to Add Expense screen],        tda[#badge("✓", success-green)], tda[☐],
  td[Expense list screen with date filter implemented],        tda[#badge("✓", success-green)], tda[☐],
  td[Min & max goal fields on Budget Goals screen],            tda[#badge("✓", success-green)], tda[☐],
)

#v(1em)
#note(
  "Final Note: ",
  "Refer back to Section 1 before submission to confirm every item in the alignment matrix is green. The four missing fields (start/end times, description, photo) and the min/max goal screen represent the highest-risk gaps between the Part 1 design and what is required to pass.",
  border-color: brand-blue,
  bg: info-bg
)
