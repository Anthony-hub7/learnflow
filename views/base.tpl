<!DOCTYPE html>
<html lang="fr" class="h-full bg-gray-100">
<head>
    <meta charset="UTF-8" />
    <title>LearnFlow</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#2563eb',
                        secondary: '#3b82f6',
                    }
                }
            }
        }
    </script>
</head>
<body class="h-full">
    <div class="min-h-full">
        <!-- Navigation -->
        <nav class="bg-white shadow-lg">
            <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
                <div class="flex h-16 justify-between items-center">
                    <div class="flex items-center space-x-6">
                        <div class="flex flex-shrink-0 items-center">
                            <h1 class="text-2xl font-bold text-primary">
                                <a href="/" class="flex items-center space-x-2">
                                    <i class="fas fa-graduation-cap"></i>
                                    <span>LearnFlow</span>
                                </a>
                            </h1>
                        </div>
                        <div class="hidden sm:flex sm:space-x-8">
                            <a href="/categories" class="inline-flex items-center border-b-2 border-transparent px-1 pt-1 text-sm font-medium text-gray-500 hover:border-primary hover:text-gray-700">
                                <i class="fas fa-folder-tree mr-2"></i>
                                Catégories
                            </a>
                            <a href="/subjects" class="inline-flex items-center border-b-2 border-transparent px-1 pt-1 text-sm font-medium text-gray-500 hover:border-primary hover:text-gray-700">
                                <i class="fas fa-book mr-2"></i>
                                Matières
                            </a>
                            <a href="/documents" class="inline-flex items-center border-b-2 border-transparent px-1 pt-1 text-sm font-medium text-gray-500 hover:border-primary hover:text-gray-700">
                                <i class="fas fa-file-alt mr-2"></i>
                                Documents
                            </a>
                             <a href="/tags" class="inline-flex items-center border-b-2 border-transparent px-1 pt-1 text-sm font-medium text-gray-500 hover:border-primary hover:text-gray-700">
                                <i class="fas fa-tags mr-2"></i>
                                Tags
                            </a>
                        </div>
                    </div>
                    <div class="flex items-center">
                        % if isAdmin:
                            <a href="/logout" title="Se déconnecter" class="text-gray-500 hover:text-gray-700">
                                <i class="fas fa-sign-out-alt fa-lg"></i>
                            </a>
                        % else:
                            <a href="/login" title="Se connecter" class="text-gray-500 hover:text-gray-700">
                                <i class="fas fa-sign-in-alt fa-lg"></i>
                            </a>
                        % end
                    </div>
                </div>
            </div>
        </nav>

        <!-- Main content -->
        <main>
            <div class="mx-auto max-w-7xl py-6 sm:px-6 lg:px-8">
                <div class="px-4 py-4 sm:px-0">
                    {{!base}}
                </div>
            </div>
        </main>
    </div>

    <!-- Toast notifications container -->
    <div id="toast" class="fixed bottom-4 right-4 z-50"></div>
</body>
</html>
