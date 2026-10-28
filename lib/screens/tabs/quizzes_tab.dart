import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../providers/loyalty_provider.dart';
import '../../theme/app_theme.dart';
import '../quiz_play_screen.dart';
import '../true_false_screen.dart';
import '../word_puzzle_screen.dart';

class QuizzesTab extends StatelessWidget {
  const QuizzesTab({super.key});

  IconData _resolveIcon(String iconName) {
    switch (iconName) {
      case 'stadium':
        return Icons.stadium_rounded;
      case 'military_tech':
        return Icons.military_tech_rounded;
      case 'emoji_events':
        return Icons.emoji_events_rounded;
      case 'analytics':
        return Icons.analytics_rounded;
      case 'spellcheck':
        return Icons.spellcheck_rounded;
      case 'sports_soccer':
        return Icons.sports_soccer_rounded;
      default:
        return Icons.sports_soccer_rounded;
    }
  }

  Color _resolveColor(String hexColor) {
    try {
      final hex = hexColor.replaceAll('#', '');
      return Color(int.parse('FF$hex', radix: 16));
    } catch (_) {
      return AppTheme.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LoyaltyProvider>();
    final bundle = provider.bundle;

    if (provider.isLoading || bundle == null) {
      return const Center(
        child: CircularProgressIndicator(color: AppTheme.primary),
      );
    }

    final categories = bundle.categories;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Zenit Stadium Scoreboard Hero Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: AppTheme.heroGradient,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppTheme.primary.withAlpha(90), width: 1.5),
                  boxShadow: AppTheme.neonGlow,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.stadium_rounded, size: 16, color: AppTheme.secondary),
                            const SizedBox(width: 6),
                            Text(
                              'ТАБЛО АРЕНЫ • РПЛ 2026',
                              style: GoogleFonts.outfit(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.secondary,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppTheme.primary.withAlpha(30),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppTheme.primary.withAlpha(80)),
                          ),
                          child: Text(
                            'Сектор Болельщика',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryLight,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Матч-Центр Зенит.',
                      style: GoogleFonts.outfit(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Проверь эрудицию в битвах клубов РПЛ, поднимайся в турнирной таблице и открывай призы!',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppTheme.textSecondary,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          final firstCategory = categories.firstWhere(
                            (c) => c.questions.isNotEmpty,
                            orElse: () => categories.first,
                          );
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => QuizPlayScreen(category: firstCategory),
                            ),
                          );
                        },
                        icon: const Icon(Icons.sports_soccer_rounded, color: Colors.white, size: 20),
                        label: Text(
                          'Выйти на Поле (Матч Дня)',
                          style: GoogleFonts.outfit(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 2. RPL Clubs Strip (Unique to Zenit Arena)
              Text(
                'Клубы Премьер-Лиги',
                style: GoogleFonts.outfit(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 38,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildClubBadge('🔵 Зенит', const Color(0xFF0077E6)),
                    const SizedBox(width: 8),
                    _buildClubBadge('🔴 Спартак', const Color(0xFFE51B24)),
                    const SizedBox(width: 8),
                    _buildClubBadge('🔴🔵 ЦСКА', const Color(0xFF3B82F6)),
                    const SizedBox(width: 8),
                    _buildClubBadge('🟢 Краснодар', const Color(0xFF10B981)),
                    const SizedBox(width: 8),
                    _buildClubBadge('🔴🟢 Локомотив', const Color(0xFFEF4444)),
                    const SizedBox(width: 8),
                    _buildClubBadge('⚪🔵 Динамо', const Color(0xFF60A5FA)),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // 3. 2x2 Mosaic of Game Modes (Unique to Zenit)
              Text(
                'Игровые Секторы',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  // Mode 1: Classic
                  Expanded(
                    child: _buildMosaicCard(
                      title: 'Квиз-Арена',
                      subtitle: 'Все туры',
                      icon: Icons.stadium_rounded,
                      color: AppTheme.primaryLight,
                      onTap: () {
                        final firstCategory = categories.firstWhere(
                          (c) => c.questions.isNotEmpty,
                          orElse: () => categories.first,
                        );
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => QuizPlayScreen(category: firstCategory),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Mode 2: Word puzzle
                  Expanded(
                    child: _buildMosaicCard(
                      title: 'Слово-Пазл',
                      subtitle: 'Термины',
                      icon: Icons.spellcheck_rounded,
                      color: AppTheme.secondary,
                      onTap: () {
                        final wordCat = categories.firstWhere(
                          (c) => c.words.isNotEmpty,
                          orElse: () => categories.last,
                        );
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => WordPuzzleScreen(words: wordCat.words),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  // Mode 3: True False
                  Expanded(
                    child: _buildMosaicCard(
                      title: 'Судейский VAR',
                      subtitle: 'Правда/Миф',
                      icon: Icons.verified_rounded,
                      color: AppTheme.accentGreen,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => TrueFalseScreen(facts: bundle.trueFalseFacts),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Mode 4: Random Blitz
                  Expanded(
                    child: _buildMosaicCard(
                      title: 'Турнирный Зал',
                      subtitle: 'Выбор тура',
                      icon: Icons.emoji_events_rounded,
                      color: AppTheme.accentGold,
                      onTap: () {
                        final randomCat = categories.isNotEmpty ? categories.last : categories.first;
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => QuizPlayScreen(category: randomCat),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // 4. Categories Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Турнирные Категории',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  Text(
                    '${categories.length} категорий',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryLight,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categories.length,
                separatorBuilder: (context, index) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  final isWordCategory = cat.words.isNotEmpty;
                  final itemCount = isWordCategory
                      ? '${cat.words.length} терминов'
                      : '${cat.questions.length} вопросов';
                  final catColor = _resolveColor(cat.colorHex);

                  return InkWell(
                    onTap: () {
                      if (isWordCategory) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => WordPuzzleScreen(words: cat.words),
                          ),
                        );
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => QuizPlayScreen(category: cat),
                          ),
                        );
                      }
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceCard,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: catColor.withAlpha(60)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              color: catColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: catColor.withAlpha(80)),
                            ),
                            child: Icon(
                              _resolveIcon(cat.icon),
                              color: catColor,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cat.title,
                                  style: GoogleFonts.outfit(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  itemCount,
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppTheme.surface,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 12,
                              color: AppTheme.primaryLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClubBadge(String name, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.surfaceCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withAlpha(80)),
      ),
      child: Center(
        child: Text(
          name,
          style: GoogleFonts.outfit(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildMosaicCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.surfaceCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withAlpha(70)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withAlpha(25),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
                  ),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(fontSize: 10, color: AppTheme.textSecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
