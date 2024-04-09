#!/bin/bash

# clear screen
clear

# Set variables
SCRATCH_ORG_ALIAS="MyBllingPreviewTestOrg"
PACKAGE_ID="04tGB000002uVoC"
PERMISSION_SET_NAME="advpm__AdvoLogixAdmin"
SCRATCH_ORG_DEF_PATH="config/project-scratch-def.json"

# Step 0: Delete Existing Scratch Org
echo "Deleting existing Scratch Org..."
sf org delete scratch --target-org $SCRATCH_ORG_ALIAS --no-prompt

# Step 1: Create a Scratch Org
echo "Creating Scratch Org..."
sf org create scratch --definition-file $SCRATCH_ORG_DEF_PATH --alias $SCRATCH_ORG_ALIAS --set-default --duration-days 30

# Step 2: Install Salesforce Package
echo "Installing package with ID $PACKAGE_ID..."
sf package install --package $PACKAGE_ID --target-org $SCRATCH_ORG_ALIAS --publish-wait 25 --wait 25

# Step 3: Assign Permission Set
echo "Assigning Permission Set $PERMISSION_SET_NAME..."
sf org assign permset --name $PERMISSION_SET_NAME --target-org $SCRATCH_ORG_ALIAS

# Step 4: Push Source Code to Scratch Org
echo "Pushing source code to Scratch Org..."
sf project deploy start --target-org $SCRATCH_ORG_ALIAS --wait 20

echo "Assigning Testing App Permission Set $PERMISSION_SET_NAME..."
sf org assign permset --name 'BillingPreview_Test_PS' --target-org $SCRATCH_ORG_ALIAS

sf apex run --file ./scripts/postInstall.apex --target-org $SCRATCH_ORG_ALIAS

# Step 5: Open the Scratch Org
sf org open --target-org $SCRATCH_ORG_ALIAS -p lightning/n/Billing_Preview_Test_Page