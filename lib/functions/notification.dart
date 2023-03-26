// Widget notification(context, setState) {
//   return AnimatedPositioned(
//     duration: const Duration(milliseconds: 400),
//     curve: Curves.easeInOutBack,
//     top: isShowNotification ? 0 : -300,
//     child: Container(
//       width: width - 60,
//       alignment: Alignment.center,
//       margin: const EdgeInsets.all(30),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//           color: isError ? myColor(4) : myColor(5),
//           borderRadius: BorderRadius.circular(25)),
//       child: Text(
//         currentError,
//         maxLines: 3,
//         style: TextStyle(fontSize: 20, color: myColor(2)),
//       ),
//     ),
//   );
// }