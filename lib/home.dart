import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var random = Random();

  List<int> snakePosition = [44,45,46,47,48];
  late int ApplePosition;
  var direction;
  var Prevdirection;

  @override
  void initState() {
    ApplePosition = random.nextInt(400);
    direction = 'right';
    updatePrev();
    
    startGame();
    setBallPos();
    super.initState();
  }

  updatePrev() {
      setState(() {
        Prevdirection = direction;
      });

  }

  startGame() {
   
    Timer.periodic(Duration(milliseconds: 300),(timer){
      
      updateSnakePosition();
    });
    
  }
  setBallPos() {
    
    Timer.periodic(Duration(milliseconds: 30),(timer){
      print('))))))))))))))))))))))))))))))))');
      if (ApplePosition == snakePosition.last) {
        updateBall();
      } 
    });
   
  }

  updateBall() {
      print('************');
      setState(() {
        print(ApplePosition);
        print(snakePosition.last);
        if (ApplePosition == snakePosition.last) {
         
          //snakePosition.add(snakePosition.last);

          if (direction == 'up') {
            snakePosition.add(snakePosition.last-20);
            ApplePosition = random.nextInt(400);
          }
          if (direction == 'down') {
            snakePosition.add(snakePosition.last+20);
            ApplePosition = random.nextInt(400);
          }
          if (direction == 'right') {
            snakePosition.add(snakePosition.last+1);
            ApplePosition = random.nextInt(400);
          }
          if (direction == 'left') {
            snakePosition.add(snakePosition.last-1);
            ApplePosition = random.nextInt(400);
          }
          
        }
         
      });
     
  
  }

  updateSnakePosition() {
    setState(() {
      switch(direction) {
        case 'up':
          // check if face left or right else already up

            // snakePosition.last = snakePosition.last - 20;
            print(Prevdirection);
            if (Prevdirection != 'down') {
              if (snakePosition.last < 20) {
                snakePosition.add(snakePosition.last + 400);
                snakePosition.removeAt(0);
              }

              snakePosition.add(snakePosition.last - 20);
              snakePosition.removeAt(0);
            } else {
              
            }

        case 'down':
        
            // snakePosition.last = snakePosition.last + 20;
            print(Prevdirection);
            if (Prevdirection != 'up') {
              if (snakePosition.last > 380) {
                snakePosition.add(snakePosition.last - 400);
                snakePosition.removeAt(0);
              }
              snakePosition.add(snakePosition.last + 20);
              snakePosition.removeAt(0);
            }else {
           
            }
    
        case 'left':
      
              // snakePosition.last = snakePosition.last - 1;
            print(Prevdirection);
            if (Prevdirection != 'right') {
              if (snakePosition.last % 20 == 0) {
                snakePosition.add(snakePosition.last - 1 + 20);
                snakePosition.removeAt(0);
              }
              snakePosition.add(snakePosition.last - 1);
              snakePosition.removeAt(0);
            }else {
              
            }

        case 'right':
              // 20 1
              // snakePosition.last = snakePosition.last + 1;
            print(Prevdirection);
            if (Prevdirection != 'left') {
                if ((snakePosition.last+1) % 20 == 0) {
                  snakePosition.add(snakePosition.last +1 - 20);
                  snakePosition.removeAt(0);
                } 
                snakePosition.add(snakePosition.last + 1);
                snakePosition.removeAt(0);
                
            }else {
               
            }
      }
    });
  }
  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        
        backgroundColor: Colors.blueGrey.shade900,
        title: Center(child: Text(widget.title, style: TextStyle(color: Colors.white),)),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: 400,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 20), 
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.all(2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: snakePosition.contains(index) ? Container(color: Colors.white,) : index ==ApplePosition? Container(color: Colors.red,):Container(color: Colors.blueGrey.shade700,),
                  )
                );
              }
              
            ),
          ),

          IconButton(
            onPressed: (){
              setState(() {
                updatePrev();
                direction = 'up';
              });
            }, 
            icon: Icon(Icons.arrow_upward, color: Colors.white, size: 60,)
          ),
          SizedBox(height: 30,),
          Row(
            children: [
              
              SizedBox(width: 50,),
              IconButton(
                onPressed: (){
                  setState(() {
                    updatePrev();
                    direction = 'left';
                  });
                }, 
                icon: Icon(Icons.arrow_back, color: Colors.white, size: 60,)
              ),
              SizedBox(width: 160,),
              IconButton(
                onPressed: (){
                  setState(() {
                    updatePrev();
                    direction = 'right';
                  });
                }, 
                icon: Icon(Icons.arrow_forward, color: Colors.white, size: 60,)
              ),
            ],
          ),
          SizedBox(height: 30,),
          IconButton(
            onPressed: (){
              setState(() {
                updatePrev();
                direction = 'down';
              });
            }, 
            icon: Icon(Icons.arrow_downward, color: Colors.white, size: 60,)
          ),
        ],
      ),
    );
  }
}
