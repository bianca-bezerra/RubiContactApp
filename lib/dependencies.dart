import 'package:google_maps/controllers/create_contact_controller.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
    create: (context) => CreateContactController(
    ),
  ),
 
];
