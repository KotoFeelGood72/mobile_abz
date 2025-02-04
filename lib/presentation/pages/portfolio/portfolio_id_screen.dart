import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_abz/app/repository/repository.dart';
import 'package:mobile_abz/presentation/widgets/post_template.dart';

@RoutePage()
class PortfolioIdScreen extends StatefulWidget {
  final String id;

  const PortfolioIdScreen({
    super.key,
    @PathParam('id') required this.id,
  });

  @override
  State<PortfolioIdScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioIdScreen> {
  final ApiRepository _repository = ApiRepository();

  Map<String, dynamic>? _post;
  bool _isLoading = true; // Добавляем состояние загрузки

  Future<void> _fetchPost() async {
    try {
      final data =
          await _repository.fetchData('gallery/post-${widget.id}.json');
      setState(() {
        _post = data;
      });

      print(_post);
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false; // Завершаем загрузку
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return PostTemplate(content: _post, isLoading: _isLoading);
  }
}
