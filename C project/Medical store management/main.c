#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX_MEDICINES 100  // Maximum number of medicines
#define MAX_USERS 10  // Maximum number of users

// Function prototypes
void addMedicine(int ids[], char names[][50], char expiryDates[][15], float prices[], int quantities[], int *totalMedicines);
void updateMedicine(int ids[], char names[][50], char expiryDates[][15], float prices[], int quantities[], int totalMedicines);
void deleteMedicine(int ids[], char names[][50], char expiryDates[][15], float prices[], int quantities[], int *totalMedicines);
void viewStock(int ids[], char names[][50], char expiryDates[][15], float prices[], int quantities[], int totalMedicines);
void searchMedicine(int ids[], char names[][50], char expiryDates[][15], float prices[], int quantities[], int totalMedicines);
void manageSales(int ids[], char names[][50], float prices[], int quantities[], int totalMedicines);
void trackExpiry(int ids[], char names[][50], char expiryDates[][15], int totalMedicines);
void generateReports(float prices[], int quantities[], int totalMedicines);
int authenticateUser(char usernames[][20], char passwords[][20], int totalUsers);

// Function to initialize the medicines in stock


int main() {
    int ids[MAX_MEDICINES]= {10.50, 15.00, 8.25, 12.50, 20.00, 5.75, 18.00, 22.50, 30.00, 25.00}; // Array to store medicine IDs
    char names[MAX_MEDICINES][50]= {
        "Paracetamol",
        "Ibuprofen",
        "Aspirin",
        "Amoxicillin",
        "Lisinopril",
        "Metformin",
        "Simvastatin",
        "Omeprazole",
        "Levothyroxine",
        "Atorvastatin"
    }; // Array to store medicine names
    char expiryDates[MAX_MEDICINES][15]={
        "10/12/2025",
        "05/01/2026",
        "15/11/2024",
        "20/02/2025",
        "10/08/2024",
        "30/04/2023",
        "12/12/2023",
        "22/03/2025",
        "01/09/2024",
        "15/10/2026"
    }; // Array to store expiry dates
    float prices[MAX_MEDICINES]= {10.50, 15.00, 8.25, 12.50, 20.00, 5.75, 18.00, 22.50, 30.00, 25.00};; // Array to store prices
    int quantities[MAX_MEDICINES]= {100, 200, 150, 120, 90, 60, 75, 80, 110, 50};; // Array to store quantities
    char usernames[MAX_USERS][20] = {"admin"}; // Default username for authentication
    char passwords[MAX_USERS][20] = {"admin"}; // Default password for authentication
    int totalMedicines = 10; // Counter for total medicines
    int totalUsers = 1; // Counter for total users
    int choice,usercat;
// checking if its manager or a customer

login:
printf("Choose which login you want to make\n");
printf("1.Customer\n");
printf("2.Manager\n");
printf("3.Exit\n");
scanf("%d",&usercat);
 if(usercat==1){int userc;
 customer_window:
printf("Which of the following task do you want to perform\n");
printf("1.Purchase medicine\n");
printf("2.view stock\n");
printf("3.Search Medicine\n");
printf("4.Go back to Login\n");
scanf("%d",&userc);
switch(userc){
    case 1:  manageSales(ids, names, prices, quantities, totalMedicines);goto customer_window;
                break;
    case 2:  viewStock(ids, names, expiryDates, prices, quantities, totalMedicines);goto customer_window;
                break;
    case 3: searchMedicine(ids, names, expiryDates, prices, quantities, totalMedicines);goto manager_window;
                break;     
    case 4: goto login;  
    default: printf("Please enter 1 or 2");
}
}
if(usercat==3){printf("Exiting....!!!");}
    
    if(usercat==2){ // User authentication
    if(!authenticateUser(usernames, passwords, totalUsers)) {
        printf("Authentication failed! going to login window...\n");goto login;
        return 0;
    }
    

    do {manager_window:
        printf("\nMedical Store Management System\n");
        printf("1. Add Medicine\n");
        printf("2. Update Medicine\n");
        printf("3. Delete Medicine\n");
        printf("4. View Stock\n");
        printf("5. Search Medicine\n");
        printf("6. Track Expiry\n");
        printf("7. Generate Reports\n");
        printf("8. Exit\n");
        printf("9.Go back to previous window\n");
        printf("Enter your choice: ");
        scanf("%d", &choice);


        switch (choice) {
            case 1:
                addMedicine(ids, names, expiryDates, prices, quantities, &totalMedicines);goto manager_window;
                break;
            case 2:
                updateMedicine(ids, names, expiryDates, prices, quantities, totalMedicines);goto manager_window;
                break;
            case 3:
                deleteMedicine(ids, names, expiryDates, prices, quantities, &totalMedicines);goto manager_window;
                break;
            case 4:
                viewStock(ids, names, expiryDates, prices, quantities, totalMedicines);goto manager_window;
                break;
            case 5:
                searchMedicine(ids, names, expiryDates, prices, quantities, totalMedicines);goto manager_window;
                break;
        
            case 6:
                trackExpiry(ids, names, expiryDates, totalMedicines);goto manager_window;
                break;
            case 7:
                generateReports(prices, quantities, totalMedicines);goto manager_window;
                break;
            case 8:
                printf("Exiting...\n");
                break;
            case 9: goto login;
            default:
                printf("Invalid choice! Please try again.\n");
        }
    } while (choice != 9);}

    return 0;
}

// Function to add a new medicine to the inventory
void addMedicine(int ids[], char names[][50], char expiryDates[][15], float prices[], int quantities[], int *totalMedicines) {
    if (*totalMedicines >= MAX_MEDICINES) {
        printf("Cannot add more medicines. Stock is full!\n");
        return;
    }

    printf("Enter Medicine ID: ");
    scanf("%d", &ids[*totalMedicines]);
    printf("Enter Medicine Name: ");
    scanf("%s", names[*totalMedicines]);
    printf("Enter Expiry Date (dd/mm/yyyy): ");
    scanf("%s", expiryDates[*totalMedicines]);
    printf("Enter Price: ");
    scanf("%f", &prices[*totalMedicines]);
    printf("Enter Quantity: ");
    scanf("%d", &quantities[*totalMedicines]);

    (*totalMedicines)++;
    printf("Medicine added successfully!\n");
}

// Function to update an existing medicine
void updateMedicine(int ids[], char names[][50], char expiryDates[][15], float prices[], int quantities[], int totalMedicines) {
    int found = 0;
    char name[50];
    printf("Enter Medicine ID or Name to update: ");
    scanf("%s", name);

    for (int i = 0; i < totalMedicines; i++) {
        if (ids[i] == atoi(name) || strcmp(names[i], name) == 0) {
            found = 1;
            printf("Enter new Medicine Name: ");
            scanf("%s", names[i]);
            printf("Enter new Expiry Date (dd/mm/yyyy): ");
            scanf("%s", expiryDates[i]);
            printf("Enter new Price: ");
            scanf("%f", &prices[i]);
            printf("Enter new Quantity: ");
            scanf("%d", &quantities[i]);
            printf("Medicine updated successfully!\n");
            break;
        }
    }
    if (!found) {
        printf("Medicine with ID %s not found.\n", name);
    }
}

// Function to delete a medicine from the inventory
void deleteMedicine(int ids[], char names[][50], char expiryDates[][15], float prices[], int quantities[], int *totalMedicines) {
    char name[50];
    printf("Enter Medicine ID or Name to delete: ");
    scanf("%s", name);

    for (int i = 0; i < *totalMedicines; i++) {
        if (ids[i] == atoi(name) || strcmp(names[i], name) == 0) {
            // Shift medicines to remove the deleted one
            for (int j = i; j < *totalMedicines - 1; j++) {
                ids[j] = ids[j + 1];
                strcpy(names[j], names[j + 1]);
                strcpy(expiryDates[j], expiryDates[j + 1]);
                prices[j] = prices[j + 1];
                quantities[j] = quantities[j + 1];
            }
            (*totalMedicines)--;  // Decrease the total count
            printf("Medicine deleted successfully!\n");
            return;
        }
    }
    printf("Medicine with ID or Name '%s' not found.\n", name);
}

// Function to display all medicines in the inventory
void viewStock(int ids[], char names[][50], char expiryDates[][15], float prices[], int quantities[], int totalMedicines) {
    printf("\nCurrent Stock:\n");
    if (totalMedicines == 0) {
        printf("No medicines in stock.\n");
        return;
    }

    for (int i = 0; i < totalMedicines; i++) {
        printf("Medicine ID: %d\n", ids[i]);
        printf("Medicine Name: %s\n", names[i]);
        printf("Expiry Date: %s\n", expiryDates[i]);
        printf("Price: %.2f\n", prices[i]);
        printf("Quantity: %d\n", quantities[i]);
        printf("------------------------------\n");
    }
}

// Function to search for a medicine by ID or name
void searchMedicine(int ids[], char names[][50], char expiryDates[][15], float prices[], int quantities[], int totalMedicines) {
    int choice;
    printf("Search by:\n");
    printf("1. Medicine ID\n");
    printf("2. Medicine Name\n");
    printf("Enter your choice: ");
    scanf("%d", &choice);

    if (choice == 1) {
        int id, found = 0;
        printf("Enter Medicine ID: ");
        scanf("%d", &id);
        
        for (int i = 0; i < totalMedicines; i++) {
            if (ids[i] == id) {
                printf("Medicine ID: %d\n", ids[i]);
                printf("Medicine Name: %s\n", names[i]);
                printf("Expiry Date: %s\n", expiryDates[i]);
                printf("Price: %.2f\n", prices[i]);
                printf("Quantity: %d\n", quantities[i]);
                found = 1;
                break;
            }
        }
        if (!found) {
            printf("Medicine with ID %d not found.\n", id);
        }
    } else if (choice == 2) {
        char name[50];
        printf("Enter Medicine Name: ");
        scanf("%s", name);

        int found = 0;
        for (int i = 0; i < totalMedicines; i++) {
            if (strcmp(names[i], name) == 0) {
                printf("Medicine ID: %d\n", ids[i]);
                printf("Medicine Name: %s\n", names[i]);
                printf("Expiry Date: %s\n", expiryDates[i]);
                printf("Price: %.2f\n", prices[i]);
                printf("Quantity: %d\n", quantities[i]);
                found = 1;
                break;
            }
        }
        if (!found) {
            printf("Medicine with name '%s' not found.\n", name);
        }
    } else {
        printf("Invalid choice! Please select 1 or 2.\n");
    }
}

// Function to manage sales transactions
void manageSales(int ids[], char names[][50], float prices[], int quantities[], int totalMedicines) {
    char name[50];
    int quantity, found = 0;
    printf("Enter Medicine ID or Name to purchase: ");
    scanf("%s", name);
    printf("Enter Quantity to purchase: ");
    scanf("%d", &quantity);
if(quantity>0){
    for (int i = 0; i < totalMedicines; i++) {
        if (ids[i] == atoi(name) || strcmp(names[i], name) == 0) {
            found = 1;
            if (quantities[i] >= quantity) {
                quantities[i] -= quantity; // Update quantity
                printf("Sale successful! Total Price: %.2f\n", prices[i] * quantity);
            } else {
                printf("Not enough stock available!\n");
            }
            break;
        }
    }
    if (!found) {
        printf("Medicine with ID or Name '%s' not found.\n", name);
    }}else printf("Enter valid quantity");
}

// Function to track expiry dates of medicines
void trackExpiry(int ids[], char names[][50], char expiryDates[][15], int totalMedicines) {
    char currentDate[15];
    printf("Enter current date (dd/mm/yyyy): ");
    scanf("%s", currentDate);

    printf("\nExpired Medicines:\n");
    int found = 0;

    for (int i = 0; i < totalMedicines; i++) {
        if (strcmp(expiryDates[i], currentDate) < 0) {
            printf("Medicine ID: %d, Name: %s, Expiry Date: %s\n", ids[i], names[i], expiryDates[i]);
            found = 1;
        }
    }
    if (!found) {
        printf("No expired medicines found.\n");
    }
}

// Function to generate reports
void generateReports(float prices[], int quantities[], int totalMedicines) {
    printf("\nReports:\n");
    printf("Total Medicines in Stock: %d\n", totalMedicines);

    float totalValue = 0;
    for (int i = 0; i < totalMedicines; i++) {
        totalValue += prices[i] * quantities[i];
    }
    printf("Total Value of Stock: %.2f\n", totalValue);
}

// Function for user authentication
int authenticateUser(char usernames[][20], char passwords[][20], int totalUsers) {
    char username[20], password[20];
    printf("Enter username: ");
    scanf("%s", username);
    printf("Enter password: ");
    scanf("%s", password);

    for (int i = 0; i < totalUsers; i++) {
        if (strcmp(usernames[i], username) == 0 && strcmp(passwords[i], password) == 0) {
            return 1; // Authentication successful
        }
    }
    return 0; // Authentication failed
}
