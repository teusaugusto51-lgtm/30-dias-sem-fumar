import 'package:flutter/material.dart';

void main() {
  runApp(const QuitApp());
}

class QuitApp extends StatelessWidget {
  const QuitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '30 Dias Sem Fumar',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DateTime quitDate = DateTime.now().subtract(const Duration(days: 3));
  int crisesHoje = 0;

  @override
  Widget build(BuildContext context) {
    final days = DateTime.now()
        .difference(DateTime(quitDate.year, quitDate.month, quitDate.day))
        .inDays;

    return Scaffold(
      appBar: AppBar(
        title: const Text('30 Dias Sem Fumar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Dias sem fumar',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '$days',
                      style: const TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Você está vencendo um dia de cada vez.',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            /// BOTÃO DE CRISE
            FilledButton.icon(
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
              ),
              onPressed: () {
                setState(() => crisesHoje++);
                _showCrisis(context);
              },
              icon: const Icon(Icons.warning),
              label: const Text('Estou em crise — me ajude'),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _openBreathing(context),
                    icon: const Icon(Icons.air),
                    label: const Text('Respiração'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _openNexo(context),
                    icon: const Icon(Icons.smart_toy),
                    label: const Text('Falar com NEXO'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            const Text(
              'Resumo do dia',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              child: ListTile(
                title: const Text('Crises registradas hoje'),
                trailing: Text(
                  '$crisesHoje',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCrisis(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Modo Crise',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'A vontade passa. Vamos respirar juntos.',
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                _openBreathing(context);
              },
              child: const Text('Iniciar respiração'),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
                _openNexo(context);
              },
              child: const Text('Conversar com NEXO'),
            ),
          ],
        ),
      ),
    );
  }

  void _openBreathing(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const BreathingPage()),
    );
  }

  void _openNexo(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const NexoPage()),
    );
  }
}

class BreathingPage extends StatelessWidget {
  const BreathingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Respiração Guiada')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Inspire por 4 segundos',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 8),
              Text('Segure por 2 segundos'),
              SizedBox(height: 8),
              Text('Expire por 6 segundos'),
            ],
          ),
        ),
      ),
    );
  }
}

class NexoPage extends StatelessWidget {
  const NexoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NEXO — Coach')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Hoje você costuma ter mais vontade à noite.\n\n'
          '• Faça uma respiração guiada\n'
          '• Beba água\n'
          '• Mude de ambiente por 5 minutos\n\n'
          'Você consegue.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
