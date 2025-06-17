# AD Welcome Email Automation
![PowerShell](https://img.shields.io/badge/PowerShell-0078D7?style=flat&logo=powershell&logoColor=white)
![HTML](https://img.shields.io/badge/HTML-Template-orange?style=flat&logo=html5&logoColor=white)
![MIT License](https://img.shields.io/github/license/kovriginmikhail/ad-welcome-email)
![Last Commit](https://img.shields.io/github/last-commit/kovriginmikhail/ad-welcome-email)

PowerShell-based solution to auto-send bilingual welcome emails when a new AD user is created in a specific OU.
This project is designed for hybrid Microsoft Exchange environments and integrates with HR onboarding processes by sending immediate, well-branded welcome messages to new staff.

---

## ⚙️ How It Works

1. A new user is created in Active Directory under a specific Organizational Unit (OU), e.g., `OU=Bank`.
2. Windows logs Event ID `4720` — "A user account was created".
3. A Task Scheduler job is triggered by this event.
4. A PowerShell script checks:
   - That the user is under the correct OU
   - That the user has a mailbox (on-prem or cloud)
5. If verified, a welcome email is sent using a bilingual HTML template.

The email includes:
- Organization logo
- Friendly welcome message (Russian & Kazakh, side by side)
- Quick links (Outlook, Teams, Intranet)
- Contact email for IT support

---

## 🚀 Features

- Fully bilingual email layout (Kazakh and Russian)
- Clean, responsive HTML design
- Easy to customize logo, colors, and text
- Task Scheduler automation
- OU-based filtering to control delivery
- Hybrid Exchange support (on-prem and cloud)

---

## 🛠️ Usage

1. Customize the HTML template located at `Templates/welcome-bilingual.html`
2. Modify `Scripts/Send-WelcomeEmail.ps1` to reflect your domain and mail settings
3. Import the `Tasks/SendWelcomeEmail.xml` into Task Scheduler
4. Ensure SMTP settings and execution policy are properly configured

---

## 📁 Folder Structure

```
├── Scripts/
│   └── Send-WelcomeEmail.ps1
├── Templates/
│   ├── welcome-bilingual.html
│   └── welcome-bilingual-preview.png
├── Tasks/
│   └── SendWelcomeEmail.xml
├── LICENSE
├── .gitignore
└── README.md
```

---

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.
