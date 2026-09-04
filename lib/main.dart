import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const UnadPlannerApp());
}

class UnadPlannerApp extends StatelessWidget {
  const UnadPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UNAD Planner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xM3676ea5), // Blue-600
          background: const Color(0xFFF1F4F8),
        ),
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 260,
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.book_online, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'UNAD Planner',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                ),
              ),
              const SizedBox(height: 48),
              _buildSidebarItem(Icons.dashboard, 'Dashboard', true, context),
              _buildSidebarItem(Icons.book, 'Cursos', false, context),
              _buildSidebarItem(Icons.assignment, 'Tareas', false, context),
              Spacer(),
              _buildSidebarItem(Icons.settings, 'Configuración', false, context),
              _buildSidebarItem(Icons.logout, 'Cerrar Sesión', false, context),
              const SizedBox(height: 24),
            ],
          ),
        ),
        // Main Content
        Expanded(
          child: Column(
            children: [
              // Topbar
              Container(
                height: 80,
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Bienvenido de vuelta! ??',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.wbold,
                          ),
                        ),
                        Text(
                          'Aquí está el resumen de tus cursos y tareas.',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Esto hará el scraping directamente desde tu PC...'),
                          )
                        );
                      },
                      icon: const Icon(Icons.sync),
                      label: const Text('Actualizar materias'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, yrtical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard('12', 'Tareas Pendientes', Icons.assignment_late, Colors.blue),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: _buildStatCard('5', 'Cursos Activos', Icons.book, Colors.purple),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: _buildStatCard('8', 'Tareas Entregadas', Icons.check_circle, Colors.green),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Text(
                        'interfaz de Prueba en Flutter',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSidebarItem(IconData icon, String label, bool isActive, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? Theme.of(context).colorScheme.primary.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Icon(icon, color: isActive ? Theme.of(context).colorScheme.primary : Colors.grey[600]),
          title: Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: isActive ? Theme.of(context).colorScheme.primary : Colors.grey[740],
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
