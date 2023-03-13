import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color.fromRGBO(39, 47, 63, 1.0),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: [
          _createWelcome(context),
          const Text('Select your profile', 
            style: TextStyle(color: Color.fromRGBO(217, 217, 217, 1.0), fontWeight: FontWeight.bold, fontSize: 30),textAlign: TextAlign.center,),
          _createProfile(),
          _createProfile()
          ],
      ),
    );
  }


// Welcome Banner
Widget _createWelcome(BuildContext context){
  return Padding(
    padding: const EdgeInsets.fromLTRB(0.0,5.0, 0.0, 40.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,   
      children: [
        Image(image: const AssetImage('assets/images/TakumiWinkWhite.png'), 
              width: MediaQuery.of(context).size.width * 0.5, 
              height: MediaQuery.of(context).size.height * 0.1, 
              ),
        const Text('Welcome Back!', style: TextStyle(fontFamily: 'Somatic', color: Color.fromRGBO(217, 217, 217, 1.0)),),
        ],
      ),
  );
  }

// Profile Card
  Widget _createProfile(){
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                  const Expanded(
                    child:  FractionallySizedBox(
                       widthFactor: 0.70, 
                       child: Image(image: AssetImage('assets/images/TakumiWinkWhite.png'),),
                  ),), 
                  Expanded(child: 
                  Column(
                    children: [
                      Text('Username', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,),textAlign: TextAlign.start,),
                      Text('Fullname', textAlign: TextAlign.start,)
                    ],
                  ),),Expanded(child: 
                  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(onPressed: (){
          
                      }, 
                      icon: ImageIcon(AssetImage('assets/images/enter.png'),),)
                    ],
                  ),)
                  ],
            ),
          )
        ],
      ),
    );
  }
}
