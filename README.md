# Terraform Azure Dev Pipeline

Ye repository Azure infrastructure ko **Terraform** aur **GitHub Actions** ke through automate karne ke liye use hoti hai. CI/CD pipeline har push/PR par Terraform ke steps (`init`, `plan`, `apply`) automatically run karti hai.

## 📁 Project Structure

```
.
├── .github/
│   └── workflows/
│       └── dev.yml              # GitHub Actions CI/CD workflow (Dev environment)
├── environment/
│   └── dev/                     # Dev environment ke Terraform configs
├── modules/
│   └── resource/
│       ├── main.tf              # Azure resources define karta hai (RG, VNet, NSG, VM, etc.)
│       └── variable.tf          # Module ke input variables
│   └── storage/
│       ├── main.tf              # Storage Account related resources
│       └── variable.tf          # Storage module ke variables
├── .gitattributes
├── .gitignore
├── github-terraform.yml
└── README.md
```

## ⚙️ Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) installed (local testing ke liye)
- Azure subscription
- Azure Service Principal (App Registration) — CI/CD authentication ke liye
- GitHub repository secrets configure kiye hue

## 🔑 Required GitHub Secrets

Pipeline ko chalane ke liye ye secrets `Settings → Secrets and variables → Actions` me add karne hain:

| Secret Name             | Description                          |
|--------------------------|---------------------------------------|
| `AZURE_CLIENT_ID`         | Service Principal Client (App) ID     |
| `AZURE_CLIENT_SECRET`     | Service Principal Secret **Value**    |
| `AZURE_SUBSCRIPTION_ID`   | Azure Subscription ID                 |
| `AZURE_TENANT_ID`         | Azure Active Directory Tenant ID      |

> ⚠️ `AZURE_CLIENT_SECRET` me hamesha Secret **Value** daalein, Secret **ID** nahi.

## 🚀 Workflow Triggers

Workflow (`.github/workflows/dev.yml`) in cases me trigger hoti hai:

- Push on `main` branch
- Push on `feature/*` ya `feature/**` branches
- Pull requests targeting `main`

## 🛠️ Pipeline Steps

1. **Checkout Code** — Repository ko runner par checkout karta hai
2. **Setup Terraform** — Terraform CLI install karta hai
3. **Terraform Init** — Backend initialize karta hai aur modules download karta hai
4. **Terraform Format Check** — Code formatting validate karta hai
5. **Terraform Plan** — Infrastructure changes ka plan generate karta hai
6. **Terraform Apply** — (Approval ke baad) actual changes Azure par apply karta hai

## 📦 Modules

### `modules/resource`
Core Azure resources define karta hai jaise Resource Group, VNet, Subnet, NSG, Public IP, NIC, VM aur VNet Peering.

### `modules/storage`
Azure Storage Account aur related resources define karta hai.

## 🌍 Environments

Currently configured environment:

- **dev** (`environment/dev`) — Development environment ke Terraform configurations

Naye environments (jaise `staging`, `prod`) add karne ke liye `environment/` folder ke andar isi pattern ko follow karein.

## 📝 Notes

- Terraform state Azure Storage Account backend me store hota hai (remote state).
- Agar state lock issue aaye, toh Azure Portal se concerned blob ka lease break karein ya `terraform force-unlock <LOCK_ID>` use karein.
- Secrets kabhi bhi code me hardcode na karein — hamesha GitHub Secrets ka use karein.

## 🤝 Contributing

1. Naya branch banayein: `feature/<feature-name>`
2. Changes commit karein
3. Pull Request open karein `main` branch ke against
4. CI/CD pipeline automatically Terraform plan generate karegi review ke liye
