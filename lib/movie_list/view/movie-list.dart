import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movie_list/bloc/movie_list_bloc.dart';
import 'package:movies/movie_list/view/widget/item_movie.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final _scrollController = ScrollController();
  /// Оголошення змінної яка є екземпляром класу ScrollController - використовується
  /// для керування скролінгу

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    /// Додаєм слухача до _scrollController і _onScroll буде
    /// викликатися кожного разу, коли користувач прокручує сторінку.
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieListBloc, MovieListState>(builder: (context, state) {
      if (state.status == MovieStatus.failure) {
        return const Center(child: Text('Sorry! Error'));
      }
      if (state.status == MovieStatus.success) {
        if (state.movies.isEmpty) {
          return const Center(child: Text('No movies'));
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 263,
              ),
              itemBuilder: (context, index) {
                return index >= state.movies.length
                    ? const CircularProgressIndicator()
                    : MovieItem(
                        movie: state.movies[index],
                      );
              }),
        );
      }
      return const Center(child: CircularProgressIndicator());
    });
  }

  @override
  void dispose() {
    /// dispose() використовується для очищення ресурсів коли
    /// закриваєм цю сторінку чи закриваєм цей додаток

    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    /// Видаляє обробник події _onScroll з контролера прокрутки.
    /// Каскадний оператор .. - використовується для декількох операцій
    /// з одним обʼєктом
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<MovieListBloc>().add(MovieFetched());
    /// Перевіряє, чи користувач доскролив до кінця списку.
    /// Якщо користувач дійшов до кінця списку, в Bloc додається подія
    /// MovieFetched, що сигналізує про необхідність завантаження наступної
    /// порції фільмів.
  }

  bool get _isBottom {
    /// Це гетер (властивість), який перевіряє, чи користувач прокрутив
    /// список майже до кінця.

    if (!_scrollController.hasClients) return false;
    /// Перевіряє, чи контролер прокрутки має "клієнтів" (тобто чи він
    /// приєднаний до якогось скролюємого віджету). Якщо ні, то
    /// повертається false.

    final maxScroll = _scrollController.position.maxScrollExtent;
    /// Визначає максимально можливу відстань для прокрутки.

    final currentScroll = _scrollController.offset;
    /// Визначає поточну позицію прокрутки.

    return currentScroll >= (maxScroll * 0.9);
    /// - Перевіряє, чи поточна позиція прокрутки складає не менше,
    /// ніж 90% від максимально можливої відстані. Якщо так, повертається
    /// `true`, що означає, що користувач дійшов майже до кінця списку.
  }
}
