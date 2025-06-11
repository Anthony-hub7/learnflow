<div class="bg-white shadow-sm rounded-lg">
    <div class="px-4 py-5 sm:px-6">
        <div class="flex justify-between items-center">
            <h1 class="text-2xl font-semibold text-gray-900">
                <i class="fas fa-tag mr-2 text-primary"></i>
                {{tag['name']}}
            </h1>
            <div class="flex space-x-4">
                <a href="/tags/{{tag['id']}}/edit" class="inline-flex items-center px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary">
                    <i class="fas fa-edit mr-2"></i>
                    Modifier
                </a>
                <a href="/tags" class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-primary hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary">
                    <i class="fas fa-list mr-2"></i>
                    Retour à la liste
                </a>
            </div>
        </div>
    </div>

    <div class="border-t border-gray-200">
        <dl class="sm:divide-y sm:divide-gray-200">
            <div class="py-4 sm:py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                <dt class="text-sm font-medium text-gray-500">Date de création</dt>
                <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">{{tag['created_at']}}</dd>
            </div>
        </dl>
    </div>
</div>
