import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_abz/app/repository/repository.dart';
import 'package:mobile_abz/presentation/widgets/post_template.dart';

@RoutePage()
class ServicesIdScreen extends StatefulWidget {
  final String id;

  const ServicesIdScreen({
    super.key,
    @PathParam('id') required this.id,
  });

  @override
  State<ServicesIdScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesIdScreen> {
  final ApiRepository _repository = ApiRepository();

  Map<String, dynamic>? _post;
  Future<void> _fetchPost() async {
    try {
      final data =
          await _repository.fetchData('services/post-${widget.id}.json');
      setState(() {
        _post = data;
      });

      print(_post);
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return PostTemplate(content: _post);
  }
}
