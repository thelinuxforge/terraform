#!/bin/bash

set -e

BACKUP_STATE="terraform.tfstate.backup"
CURRENT_STATE="terraform.tfstate"

echo "======================================"
echo " Terraform State Recovery"
echo "======================================"

# 1. Check backup state file
if [ ! -f "$BACKUP_STATE" ]; then
    echo "ERROR: $BACKUP_STATE not found."
    exit 1
fi

echo
echo "[1/7] Checking Terraform files..."
ls -lh terraform.tfstate*

# 2. Create safety backup
echo
echo "[2/7] Creating safety backup..."

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

if [ -f "$CURRENT_STATE" ]; then
    cp "$CURRENT_STATE" "terraform.tfstate.before_recovery_$TIMESTAMP"
    echo "Current state backed up."
fi

cp "$BACKUP_STATE" "terraform.tfstate.backup.safe_$TIMESTAMP"

echo "Safety backups created."

# 3. Show resources in backup
echo
echo "[3/7] Resources in terraform.tfstate.backup:"
echo "--------------------------------------"

terraform state list -state="$BACKUP_STATE"

# 4. Show current resources
if [ -f "$CURRENT_STATE" ]; then
    echo
    echo "[4/7] Resources in current terraform.tfstate:"
    echo "--------------------------------------"

    terraform state list

    echo
    echo "======================================"
    echo " Comparing states"
    echo "======================================"

    terraform state list -state="$BACKUP_STATE" > /tmp/terraform_backup_resources.txt
    terraform state list > /tmp/terraform_current_resources.txt

    echo
    echo "Resources ONLY in backup:"
    comm -23 \
        <(sort /tmp/terraform_backup_resources.txt) \
        <(sort /tmp/terraform_current_resources.txt) || true

    echo
    echo "Resources ONLY in current state:"
    comm -13 \
        <(sort /tmp/terraform_backup_resources.txt) \
        <(sort /tmp/terraform_current_resources.txt) || true

else
    echo
    echo "[4/7] Current terraform.tfstate does not exist."
    echo "Backup appears to be the only available local state."
fi

# 5. Ask before replacing state
echo
echo "======================================"
echo " IMPORTANT"
echo "======================================"
echo
echo "The next step will replace:"
echo
echo "    terraform.tfstate"
echo
echo "with:"
echo
echo "    terraform.tfstate.backup"
echo
echo "A safety copy has already been created."
echo

read -p "Do you want to restore terraform.tfstate.backup? (yes/no): " CONFIRM

if [ "$CONFIRM" != "yes" ]; then
    echo
    echo "Recovery cancelled."
    exit 0
fi

# 6. Restore state
echo
echo "[5/7] Restoring Terraform state..."

if [ -f "$CURRENT_STATE" ]; then
    mv "$CURRENT_STATE" "terraform.tfstate.old_$TIMESTAMP"
fi

cp "$BACKUP_STATE" "$CURRENT_STATE"

echo "State restored successfully."

# 7. Initialize and plan
echo
echo "[6/7] Running terraform init..."

terraform init

echo
echo "[7/7] Running terraform plan..."
echo
echo "IMPORTANT: Review the plan carefully."
echo "The script will NOT run terraform apply."
echo

terraform plan

echo
echo "======================================"
echo " Recovery process completed"
echo "======================================"
echo
echo "Current state:"
echo "  terraform.tfstate"
echo
echo "Previous state:"
echo "  terraform.tfstate.old_$TIMESTAMP"
echo
echo "Backup:"
echo "  $BACKUP_STATE"
echo
echo "Safety backup:"
echo "  terraform.tfstate.backup.safe_$TIMESTAMP"
echo
echo "DO NOT run terraform apply until you review the plan."
