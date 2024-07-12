import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smart_trivia/presentation/providers/categories_provider.dart';
import 'package:smart_trivia/presentation/providers/create_trivia_providers.dart';

class CreateTriviaScreen extends ConsumerStatefulWidget {
  const CreateTriviaScreen({super.key});

  @override
  CreateTriviaScreenState createState() => CreateTriviaScreenState();
}

class CreateTriviaScreenState extends ConsumerState<CreateTriviaScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(categoriesProvider.notifier).getCategories();
  }
  @override
  Widget build(BuildContext context) {
    final numQuestions = ref.watch(numQuestionsProvider);
    final category = ref.watch(categoryProvider);
    final categorySelected = ref.watch(categorySelectedProvider);
    final difficulty = ref.watch(difficultyProvider);
    final type = ref.watch(typeProvider);
    final categories = ref.watch(categoriesProvider);

    List<Widget> numQuestionOptions() {
      return [
        CupertinoActionSheetAction(
          onPressed: () {
            ref.read(numQuestionsProvider.notifier).update((state) => 10);
            context.pop();
          },
          child: const Text('10'),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            ref.read(numQuestionsProvider.notifier).update((state) => 20);
            context.pop();
          },
          child: const Text('20'),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            ref.read(numQuestionsProvider.notifier).update((state) => 30);
            context.pop();
          }, 
          child: const Text('30'),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            ref.read(numQuestionsProvider.notifier).update((state) => 40);
            context.pop();
          }, 
          child: const Text('40'),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            ref.read(numQuestionsProvider.notifier).update((state) => 50);
            context.pop();
          }, 
          child: const Text('50'),
        ),
      ];
    }

    List<Widget> categoryOptions() {

      List<Widget> options = categories.map<Widget>((category) => CupertinoActionSheetAction(
        onPressed: () {
          ref.read(categorySelectedProvider.notifier).update((state) => '${category.id}' );
          
            ref.read(categoryProvider.notifier).update((state) => { '${category.id}': category.name} );
            context.pop();
          },
          child: Text(category.name),
      )).toList();

      options.insert(0, CupertinoActionSheetAction(
        onPressed: () {
          ref.read(categorySelectedProvider.notifier).update((state) => '' );
          
            ref.read(categoryProvider.notifier).update((state) => { '': 'Any'} );
            context.pop();
          },
          child: Text('Any'),
      ));

      return options;
    }

    List<Widget> difficultyOptions() {
      return [
        CupertinoActionSheetAction(
          onPressed: () {
            ref.read(difficultyProvider.notifier).update((state) => 'Any');
            context.pop();
          },
          child: const Text('Any'),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            ref.read(difficultyProvider.notifier).update((state) => 'easy');
            context.pop();
          },
          child: const Text('Easy'),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            ref.read(difficultyProvider.notifier).update((state) => 'medium');
            context.pop();
          },
          child: const Text('Medium'),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            ref.read(difficultyProvider.notifier).update((state) => 'hard');
            context.pop();
          }, 
          child: const Text('Hard'),
        ),
       
  
      ];
    }

    List<Widget> typeOptions() {
      return [
        CupertinoActionSheetAction(
          onPressed: () {
            ref.read(typeProvider.notifier).update((state) => 'Any');
            context.pop();
          },
          child: const Text('Any'),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            ref.read(typeProvider.notifier).update((state) => 'multiple');
            context.pop();
          },
          child: const Text('Multiple Choice'),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            ref.read(typeProvider.notifier).update((state) => 'boolean');
            context.pop();
          }, 
          child: const Text('True / False'),
        ),
       
  
      ];
    }

    void showBottomSheet({ required String title, required List<Widget> options } ) {
  
      showCupertinoModalPopup(context: context, builder: (context,) => CupertinoActionSheet(
        title: Text(title),
        actions: options,
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () => context.pop(), child: const Text('Cancel'),
        ),
      ),
  
      );

    }

    String getTypeLabel(String value) {
      if(value == 'boolean') return 'True / False';
      if(value == 'multiple') return 'Multiple Choice';
      return 'Any';
    }

    String camelToSentence(String text) {
      var result = text.replaceAll(RegExp(r'(?<!^)(?=[A-Z])'), r" ");
      var finalResult = result[0].toUpperCase() + result.substring(1);
      return finalResult;
    }

  
    

    return Scaffold(
      appBar: AppBar(
        // title: const Text('Create New Trivia', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFFB063C0),
        
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration( 
              gradient: LinearGradient( 
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFB063C0), 
                  Color(0xFFB195F9), 
                  Colors.white
                  ], 
              ), 
            ), 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/img/logo.png', width: 250,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:  20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CupertinoListSection(
                      header: const Text('Main Menu'),
                        
                        children: [
                          CupertinoListTile(
                            leading: const Icon(Icons.numbers, color: Colors.black54,),
                            trailing: const Icon(Icons.chevron_right_rounded),
                            title: const Text('Number of Questions'),
                            subtitle: Text('$numQuestions'),
                            onTap: () => showBottomSheet( title: 'Number of Questions', options: numQuestionOptions()),
                          ),
                          CupertinoListTile(
                            leading: const Icon(Icons.category_rounded, color: Colors.black54,),
                            trailing: const Icon(Icons.chevron_right_rounded),
                            title: const Text('Category'),
                            subtitle: Text(category[categorySelected] ?? 'Any'),
                            onTap: () => showBottomSheet( title: 'Select Category', options: categoryOptions()),
                          ),
                          CupertinoListTile(
                            leading: const Icon(Icons.bar_chart_rounded, color: Colors.black54,),
                            trailing: const Icon(Icons.chevron_right_rounded),
                            title: const Text('Difficulty'),
                            subtitle: Text(camelToSentence(difficulty) ),
                            onTap: () => showBottomSheet( title: 'Select Difficulty', options: difficultyOptions()),
                          ),
                          CupertinoListTile(
                            leading: Icon(Icons.shape_line_rounded, color: Colors.black54,),
                            trailing: Icon(Icons.chevron_right_rounded),
                            title: Text('Questions Type'),
                            subtitle: Text(getTypeLabel(type) ),
                            onTap: () => showBottomSheet( title: 'Select Type ', options: typeOptions()),
                          ),
                              
                        ],
                      ),
                  ),
                ),

                SizedBox(height: 10,),

                ElevatedButton.icon(
                  onPressed: () {
                    Share.share('Hey! Start to play Smart Trivia https://apps.apple.com/us/app/smart-drinks-nss/id6508169189', subject: 'Hey! Start to play Smart Trivia');
                  }, 
                  icon: Icon(Icons.share_rounded), 
                  label: Text('Invite your friends'),
                ),

                const Spacer(),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: FilledButton(
                    style:  ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 245, 130, 70)),
                    onPressed: () => context.go('/trivia'), 
                    child: const Text('Create'),
                  ),
                ),

    
                const SizedBox(height: 50,),
              ],
            ),
          )
        ],
      ),
    );


  }
}


