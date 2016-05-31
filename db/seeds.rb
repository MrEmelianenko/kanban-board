# Settings
Settings.create!(
  key: 'admin_emails',
  value: 'user1@email.com user2@email.com emelianenko.web@gmail.com'
)

# Issue Types
IssueType.create!(name: 'Bug')
IssueType.create!(name: 'Task')
IssueType.create!(name: 'Improvement')
