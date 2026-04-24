// VAULT-TECH – Branch Claim Sheet
// Compile with: typst compile vault-tech-branches.typ

#set document(title: "VAULT-TECH Branch Claim Sheet", author: "VAULT-TECH Team")
#set page(paper: "a4", margin: (x: 2cm, y: 2cm))
#set text(font: "Liberation Sans", size: 10pt, fill: rgb("#424242"))
#set heading(numbering: none)

// ── Header ────────────────────────────────────────────────────────────────────
#block(
  fill: rgb("#1A237E"),
  radius: 6pt,
  inset: (x: 16pt, y: 12pt),
  width: 100%,
)[
  #text(size: 22pt, weight: "bold", fill: rgb("#F9A825"))[VAULT-TECH]
  #h(8pt)
  #text(size: 14pt, fill: white)[Branch Claim Sheet]
  #v(2pt)
  #text(size: 9pt, fill: rgb("#90CAF9"))[
    Complete the skeleton on `main` before any branch is started.
    Each team member claims one branch — write your name in the Assigned column.
  ]
]

#v(12pt)

// ── Legend ────────────────────────────────────────────────────────────────────
#text(size: 9pt, weight: "bold")[Legend: ]
#box(fill: rgb("#E8F5E9"), inset: (x:5pt, y:3pt), radius: 3pt)[#text(size:8pt, fill: rgb("#2E7D32"))[Low complexity]]
#h(4pt)
#box(fill: rgb("#FFF8E1"), inset: (x:5pt, y:3pt), radius: 3pt)[#text(size:8pt, fill: rgb("#F57F17"))[Medium complexity]]
#h(4pt)
#box(fill: rgb("#FFEBEE"), inset: (x:5pt, y:3pt), radius: 3pt)[#text(size:8pt, fill: rgb("#C62828"))[High complexity]]

#v(10pt)

// ── Section 0: Skeleton (main) ────────────────────────────────────────────────
#block(
  fill: rgb("#EDE7F6"),
  radius: 4pt,
  inset: (x: 10pt, y: 8pt),
  width: 100%,
)[
  #text(size: 11pt, weight: "bold", fill: rgb("#1A237E"))[
    Phase 0 — Skeleton (main branch) · Must be merged before any feature branch starts
  ]
]

#v(6pt)

#table(
  columns: (2fr, 3fr, 1.5fr, 1.5fr),
  fill: (col, row) => if row == 0 { rgb("#1A237E") } else if calc.odd(row) { rgb("#F5F5F5") } else { white },
  stroke: rgb("#E0E0E0"),
  inset: (x: 8pt, y: 6pt),

  // Header
  text(fill: white, weight: "bold", size: 9pt)[File / Component],
  text(fill: white, weight: "bold", size: 9pt)[Responsibility],
  text(fill: white, weight: "bold", size: 9pt)[Assigned To],
  text(fill: white, weight: "bold", size: 9pt)[Done ✓],

  // Rows
  `build.gradle (app)`,        [Room, MPAndroidChart, Glide, Coroutines, ViewModel deps],  [\_\_\_\_\_\_\_\_\_\_], [],
  `AppDatabase.kt`,            [Wire all 4 entities; singleton pattern],                    [\_\_\_\_\_\_\_\_\_\_], [],
  `Entity: User.kt`,           [All fields + PK; SHA-256 note in comment],                  [\_\_\_\_\_\_\_\_\_\_], [],
  `Entity: Category.kt`,       [All fields incl. colourHex],                                [\_\_\_\_\_\_\_\_\_\_], [],
  `Entity: Expense.kt`,        [All fields incl. 4 new fields (⚠ TDD gap)],                 [\_\_\_\_\_\_\_\_\_\_], [],
  `Entity: Goal.kt`,           [minGoal + maxGoal (⚠ TDD gap)],                             [\_\_\_\_\_\_\_\_\_\_], [],
  `UserDao.kt`,                [Stub method signatures only],                               [\_\_\_\_\_\_\_\_\_\_], [],
  `CategoryDao.kt`,            [Stub method signatures only],                               [\_\_\_\_\_\_\_\_\_\_], [],
  `ExpenseDao.kt`,             [Stub method signatures only],                               [\_\_\_\_\_\_\_\_\_\_], [],
  `GoalDao.kt`,                [Stub method signatures only],                               [\_\_\_\_\_\_\_\_\_\_], [],
  `colors.xml`,                [Full brand palette from TDD Section 7],                     [\_\_\_\_\_\_\_\_\_\_], [],
  `themes.xml`,                [Material3.DayNight.NoActionBar base theme],                 [\_\_\_\_\_\_\_\_\_\_], [],
  `AndroidManifest.xml`,       [All Activities declared + FileProvider],                    [\_\_\_\_\_\_\_\_\_\_], [],
  `BaseActivity.kt`,           [SharedPreferences session helpers],                         [\_\_\_\_\_\_\_\_\_\_], [],
)

#v(14pt)

#pagebreak()

// ── Section 1: Feature Branches ───────────────────────────────────────────────
#block(
  fill: rgb("#E3F2FD"),
  radius: 4pt,
  inset: (x: 10pt, y: 8pt),
  width: 100%,
)[
  #text(size: 11pt, weight: "bold", fill: rgb("#1A237E"))[
    Phase 1 — Feature Branches · One branch per row below
  ]
]

#v(6pt)

#table(
  columns: (1.6fr, 1.8fr, 2.2fr, 1fr, 1.2fr, 1.2fr),
  fill: (col, row) => if row == 0 { rgb("#1A237E") } else if calc.odd(row) { rgb("#F5F5F5") } else { white },
  stroke: rgb("#E0E0E0"),
  inset: (x: 7pt, y: 6pt),

  // Header
  text(fill: white, weight: "bold", size: 9pt)[Branch Name],
  text(fill: white, weight: "bold", size: 9pt)[Screens],
  text(fill: white, weight: "bold", size: 9pt)[Key Deliverables],
  text(fill: white, weight: "bold", size: 9pt)[Complexity],
  text(fill: white, weight: "bold", size: 9pt)[Assigned To],
  text(fill: white, weight: "bold", size: 9pt)[Done ✓],

  // feature/auth
  `feature/auth`,
  [SplashActivity\ LoginActivity\ SignUpActivity],
  [Session routing on splash; SharedPreferences login; full sign-up validation (email, DOB 13+, password rules)],
  box(fill: rgb("#FFF8E1"), inset:(x:4pt,y:2pt), radius:3pt)[#text(size:8pt, fill:rgb("#F57F17"))[Medium]],
  [\_\_\_\_\_\_\_\_\_\_],
  [],

  // feature/home
  `feature/home`,
  [HomeActivity\ HomeFragment],
  [BottomNavigationView; PieChart stub (MPAndroidChart); warning banner CardView; notification bell],
  box(fill: rgb("#FFF8E1"), inset:(x:4pt,y:2pt), radius:3pt)[#text(size:8pt, fill:rgb("#F57F17"))[Medium]],
  [\_\_\_\_\_\_\_\_\_\_],
  [],

  // feature/expenses
  `feature/expenses`,
  [AddExpenseActivity\ ExpenseListActivity\ ExpenseDetailActivity],
  [⚠ All 4 new fields (startTime, endTime, description, photo); FileProvider camera/gallery; RecyclerView list with date filter; Glide image load],
  box(fill: rgb("#FFEBEE"), inset:(x:4pt,y:2pt), radius:3pt)[#text(size:8pt, fill:rgb("#C62828"))[High]],
  [\_\_\_\_\_\_\_\_\_\_],
  [],

  // feature/goals
  `feature/goals`,
  [BudgetGoalsActivity],
  [⚠ Min + max goal fields (two EditTexts); SeekBar sync; upsert Goal entity; progress CardView],
  box(fill: rgb("#E8F5E9"), inset:(x:4pt,y:2pt), radius:3pt)[#text(size:8pt, fill:rgb("#2E7D32"))[Low]],
  [\_\_\_\_\_\_\_\_\_\_],
  [],

  // feature/reports
  `feature/reports`,
  [CategoryTotalsActivity],
  [BarChart (MPAndroidChart); date-range filter; totals RecyclerView with goal indicators (green/red ProgressBar)],
  box(fill: rgb("#FFF8E1"), inset:(x:4pt,y:2pt), radius:3pt)[#text(size:8pt, fill:rgb("#F57F17"))[Medium]],
  [\_\_\_\_\_\_\_\_\_\_],
  [],

  // feature/profile
  `feature/profile`,
  [ProfileActivity\ EditProfileActivity\ AchievementsActivity],
  [Circular profile picture; 6 achievement badges RecyclerView; level ProgressBar; sign-out clears SharedPreferences],
  box(fill: rgb("#E8F5E9"), inset:(x:4pt,y:2pt), radius:3pt)[#text(size:8pt, fill:rgb("#2E7D32"))[Low]],
  [\_\_\_\_\_\_\_\_\_\_],
  [],

  // feature/viewmodels
  `feature/viewmodels`,
  [All ViewModels\ All Repositories],
  [LiveData fields; Repository abstractions over DAOs; Coroutine scopes; stub implementations returning empty lists],
  box(fill: rgb("#FFEBEE"), inset:(x:4pt,y:2pt), radius:3pt)[#text(size:8pt, fill:rgb("#C62828"))[High]],
  [\_\_\_\_\_\_\_\_\_\_],
  [],

  // feature/ci
  `feature/ci`,
  [No screens],
  [.github/workflows/build.yml; README.md with setup + video link; Unit test stubs; Instrumented DAO test stubs],
  box(fill: rgb("#E8F5E9"), inset:(x:4pt,y:2pt), radius:3pt)[#text(size:8pt, fill:rgb("#2E7D32"))[Low]],
  [\_\_\_\_\_\_\_\_\_\_],
  [],
)

#v(14pt)

// ── Section 2: TDD High-Risk Gaps Reminder ────────────────────────────────────
#block(
  fill: rgb("#FFEBEE"),
  radius: 4pt,
  inset: (x: 10pt, y: 8pt),
  width: 100%,
  stroke: (paint: rgb("#C62828"), thickness: 1pt),
)[
  #text(size: 10pt, weight: "bold", fill: rgb("#C62828"))[⚠  TDD High-Risk Gaps — must not be missed]
  #v(4pt)
  #grid(
    columns: (1fr, 1fr),
    gutter: 8pt,
    [
      #text(size: 9pt)[
        *1. AddExpenseActivity* (`feature/expenses`)\
        Four fields were missing from the Part 1 wireframe:\
        `startTime`, `endTime`, `description`, `photoPath`\
        All four are required fields in the Expense entity.
      ]
    ],
    [
      #text(size: 9pt)[
        *2. BudgetGoalsActivity* (`feature/goals`)\
        Original design had a single budget amount.\
        Assignment requires *both* `minGoal` and `maxGoal`.\
        Both fields must appear in the UI and the Goal entity.
      ]
    ],
  )
]

#v(10pt)

// ── Footer ────────────────────────────────────────────────────────────────────
#line(length: 100%, stroke: rgb("#E0E0E0"))
#v(4pt)
#text(size: 8pt, fill: rgb("#9E9E9E"))[
  VAULT-TECH · Personal Budgeting App · Android · Kotlin · RoomDB · MVVM · TDD v1.0 · For Academic Use Only
]
