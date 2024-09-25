"""
Views for the recipe Apis.
"""
from rest_framework import viewsets
from rest_framework.authentication import TokenAuthentication
from rest_framework.permissions import IsAuthenticated

from core.models import Recipe
from recipe import serializers


class RecipeViewSet(viewsets.ModelViewSet):
    """View for manage recipe APis"""
    serializer_class = serializers.RecipeSerializer
    queryset = Recipe.objects.all()
    authentications_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]
    