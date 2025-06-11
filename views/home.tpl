<!DOCTYPE html>
<html lang="fr" class="h-full bg-gray-100">
<head>
    <meta charset="UTF-8" />
    <title>LearnFlow - Accueil</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#2563eb',
                        secondary: '#3b82f6',
                        light: '#f1f5f9'
                    }
                }
            }
        }
    </script>

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

    <!-- Vue 3 (facultatif si tu veux ajouter de l’interaction) -->
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
</head>
<body class="h-full text-gray-800">
    <div class="min-h-full flex flex-col">
        <!-- Header -->
        <nav class="bg-white shadow-md">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex h-16 items-center justify-between">
                    <a href="/" class="text-primary text-2xl font-bold flex items-center space-x-2">
                        <i class="fas fa-graduation-cap"></i>
                        <span class="hidden sm:inline">LearnFlow</span>
                    </a>
                    <div class="flex space-x-6 text-xl text-gray-600">
                        <a href="/categories" class="hover:text-primary" title="Catégories">
                            <i class="fas fa-folder-tree"></i>
                        </a>
                        <a href="/subjects" class="hover:text-primary" title="Matières">
                            <i class="fas fa-book"></i>
                        </a>
                        <a href="/documents" class="hover:text-primary" title="Documents">
                            <i class="fas fa-file-alt"></i>
                        </a>
                        <a href="/tags" class="hover:text-primary" title="Tags">
                            <i class="fas fa-tags"></i>
                        </a>
                    </div>
                </div>
            </div>
        </nav>

        <!-- Hero Section -->
        <header class="bg-white py-16 shadow-sm">
            <div class="max-w-4xl mx-auto text-center px-4">
                <h1 class="text-5xl font-extrabold text-primary mb-4">Bienvenue sur LearnFlow</h1>
                <p class="text-lg text-gray-600 mb-6">
                    Un espace conçu pour organiser vos connaissances, retrouver vos documents, et progresser efficacement dans vos apprentissages.
                </p>
                <a href="/documents" class="inline-block bg-primary hover:bg-blue-700 text-white font-semibold py-3 px-6 rounded-xl shadow transition">
                    Accéder aux ressources
                </a>
            </div>
        </header>

        <!-- Resources Section -->
        <main class="flex-1 bg-light py-14">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <h2 class="text-3xl font-bold text-gray-800 mb-8 text-center">Explorez vos ressources</h2>

                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
                    <a href="/categories" class="bg-white rounded-xl shadow p-6 hover:shadow-lg transition">
                        <i class="fas fa-folder-tree text-4xl text-secondary mb-4"></i>
                        <h3 class="text-xl font-semibold mb-2">Catégories</h3>
                        <p class="text-gray-500 text-sm">Classez vos sujets et documents par grands thèmes pour une navigation logique.</p>
                    </a>
                    <a href="/subjects" class="bg-white rounded-xl shadow p-6 hover:shadow-lg transition">
                        <i class="fas fa-book text-4xl text-secondary mb-4"></i>
                        <h3 class="text-xl font-semibold mb-2">Matières</h3>
                        <p class="text-gray-500 text-sm">Regroupez vos documents par discipline ou matière spécifique.</p>
                    </a>
                    <a href="/documents" class="bg-white rounded-xl shadow p-6 hover:shadow-lg transition">
                        <i class="fas fa-file-alt text-4xl text-secondary mb-4"></i>
                        <h3 class="text-xl font-semibold mb-2">Documents</h3>
                        <p class="text-gray-500 text-sm">Consultez tous vos cours, notes, fichiers partagés ou annexes à portée de clic.</p>
                    </a>
                    <a href="/tags" class="bg-white rounded-xl shadow p-6 hover:shadow-lg transition">
                        <i class="fas fa-tags text-4xl text-secondary mb-4"></i>
                        <h3 class="text-xl font-semibold mb-2">Tags</h3>
                        <p class="text-gray-500 text-sm">Ajoutez des mots-clés à vos documents pour mieux les retrouver.</p>
                    </a>
                </div>
            </div>
        </main>

        <!-- Motivation Section -->
        <section class="bg-white py-16 mt-12">
            <div class="max-w-4xl mx-auto text-center px-6">
                <h2 class="text-2xl font-bold text-gray-800 mb-4">Pourquoi LearnFlow ?</h2>
                <p class="text-gray-600 text-lg mb-6">
                    Apprendre n'est pas qu'une question de contenu, c’est aussi une question d’organisation. LearnFlow vous aide à mieux structurer vos apprentissages, pour ne plus jamais perdre le fil.
                </p>
                <div class="flex flex-col sm:flex-row justify-center gap-4 mt-4">
                    <div class="bg-gray-50 p-4 rounded-lg shadow w-full sm:w-1/3">
                        <i class="fas fa-check-circle text-primary text-2xl mb-2"></i>
                        <h4 class="font-semibold mb-1">Simple à utiliser</h4>
                        <p class="text-sm text-gray-500">Une interface claire pour tous les niveaux.</p>
                    </div>
                    <div class="bg-gray-50 p-4 rounded-lg shadow w-full sm:w-1/3">
                        <i class="fas fa-sync-alt text-primary text-2xl mb-2"></i>
                        <h4 class="font-semibold mb-1">Tout synchronisé</h4>
                        <p class="text-sm text-gray-500">Vos documents classés, vos tags reliés, vos matières accessibles.</p>
                    </div>
                    <div class="bg-gray-50 p-4 rounded-lg shadow w-full sm:w-1/3">
                        <i class="fas fa-seedling text-primary text-2xl mb-2"></i>
                        <h4 class="font-semibold mb-1">Pensé pour l'évolution</h4>
                        <p class="text-sm text-gray-500">Ajoutez, filtrez, explorez et grandissez avec vos ressources.</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <footer class="bg-white shadow mt-8">
            <div class="max-w-7xl mx-auto px-4 py-6 text-center text-sm text-gray-500">
                &copy; 2025 LearnFlow — Fait avec ❤️ pour tous ceux qui veulent apprendre plus efficacement.
            </div>
        </footer>
    </div>

    <!-- Toast Notifications -->
    <div id="toast" class="fixed bottom-4 right-4 z-50 space-y-2"></div>
</body>
</html>
