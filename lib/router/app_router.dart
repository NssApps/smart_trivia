

import 'package:go_router/go_router.dart';
import 'package:smart_trivia/presentation/screens/create_trivia/create_trivia.dart';
import 'package:smart_trivia/presentation/screens/game_over/game_over_screen.dart';
import 'package:smart_trivia/presentation/screens/trivia/trivia_screen.dart';
import 'package:smart_trivia/presentation/screens/welcome/welcome_screen.dart';
import 'package:smart_trivia/presentation/screens/you_win/you_win_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/welcome',
  routes: [
    GoRoute(
      path: '/welcome',
      name: 'welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/trivia',
      name: 'trivia',
      builder: (context, state) => const TriviaScreen(),
    ),
    GoRoute(
      path: '/gameOver',
      name: 'gameOver',
      builder: (context, state) => const GameOverScreen(),
    ),
    GoRoute(
      path: '/youWin',
      name: 'youWin',
      builder: (context, state) => const YouWinScreen(),
    ),
    GoRoute(
      path: '/trivia/create',
      name: 'triviaCreate',
      builder: (context, state) => const CreateTriviaScreen(),
    ),
    // GoRoute(
    //   path: '/drinks/:id',
    //   name: 'drinks',
    //       builder: (context, state) {
    //       final String drinkId = state.pathParameters['id'] ?? 'no-id';
    //       return ShowDrinkScreen(drinkId: drinkId);
    //     },
    // ),
    // GoRoute(
    //   path: '/ingredients/:name',
    //   name: 'ingredients',
    //       builder: (context, state) {
    //       final String ingredientName = state.pathParameters['name'] ?? 'no-id';
    //       return ShowIngredientScreen(ingredientName: ingredientName);
    //     },
    // ),
    // GoRoute(
    //   path: '/drinks/ingredients/:name',
    //   name: 'drinksByIngredient',
    //       builder: (context, state) {
    //       final String ingredientName = state.pathParameters['name'] ?? 'no-id';
    //       return DrinksByIngredientScreen(ingredientName: ingredientName);
    //     },
    // ),
  
   


]);