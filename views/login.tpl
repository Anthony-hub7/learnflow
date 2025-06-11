% rebase('base')
<div class="max-w-md mx-auto bg-white p-8 rounded-lg shadow-md">
    <h2 class="text-2xl font-semibold text-gray-900 mb-6 text-center">Connexion à LearnFlow</h2>
    
    % if error:
        <div class="mb-4 rounded-md bg-red-50 p-4 text-red-700 ring-1 ring-inset ring-red-500/10">
            {{error}}
        </div>
    % end
    
    <form action="/login" method="post" class="space-y-6">
        <div>
            <label for="password" class="block text-sm font-medium text-gray-700">Mot de passe</label>
            <input type="password" name="password" id="password" required
                   class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-primary focus:ring-primary sm:text-sm" />
        </div>

        <button type="submit" 
                class="w-full inline-flex justify-center rounded-md bg-primary px-4 py-2 text-white font-semibold shadow-sm hover:bg-secondary focus:outline-none focus:ring-2 focus:ring-primary focus:ring-offset-2">
            Se connecter
        </button>
    </form>
</div>
