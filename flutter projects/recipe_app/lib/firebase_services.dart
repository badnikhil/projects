// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_app/global.dart';

class FirebaseServices {

 FirebaseFirestore firestore = FirebaseFirestore.instance;
void createUserDocument(String userID)async{
  try {
   
   

    
    DocumentSnapshot userDoc = await firestore.collection('userData').doc(userID.toString()).get();

    if (userDoc.exists) {
      print('User document already exists for userID: $userID');
    } else {
     
      Map<String, dynamic> userData = {
        'likedRecipes': [], 
        
      };

      
      await firestore.collection('userData').doc(userID.toString()).set(userData);

      print('User document created successfully!');
    }
  } catch (e) {
    print('Error checking or creating user document: $e');
  }
}

 Future<bool> isRecipeLiked(int recipeId) async {
    try {
      // Fetch the user's document from Firestore
      DocumentSnapshot userSnapshot = await firestore.collection('userData').doc(userID.toString()).get();

      // If the user's document exists
      if (userSnapshot.exists) {
        // Get the liked recipes array
        List<dynamic> likedRecipes = userSnapshot['liked'] ?? [];

        // Check if the recipeId is in the liked recipes list
        return likedRecipes.contains(recipeId);
      }

      // If the user's document does not exist or no liked recipes field
      return false;
    } catch (e) {
      print("Error checking like status: $e");
      return false;
    }
  }


void toggleLike( String mealID) async {
  
   
  DocumentSnapshot userDoc = await firestore.collection('userData')
      .doc(userID.toString())
      .get();

  if (userDoc.exists) {
    // Get the 'liked' array
    List<dynamic> likedArray = userDoc['liked'] ?? [];

    // Check if the mealID is already in the liked array
    if (likedArray.contains(mealID)) {
      // If it's already liked, remove it from the array
      FirebaseFirestore.instance
          .collection('userData')
          .doc(userID)
          .update({
            'liked': FieldValue.arrayRemove([mealID]), // Removes mealID
          })
          .then((_) {
            print("Meal removed from liked array");
          })
          .catchError((error) {
            print("Failed to remove meal from liked array: $error");
          });
    } else {
      // If it's not liked, add it to the array
      FirebaseFirestore.instance
          .collection('userData')
          .doc(userID)
          .update({
            'liked': FieldValue.arrayUnion([mealID]), // Adds mealID
          })
          .then((_) {
            print("Meal added to liked array");
          })
          .catchError((error) {
            print("Failed to add meal to liked array: $error");
          });
    }
  } else {
    print("User not found");
  }
}


}