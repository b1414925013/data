package com.chenxl.test;

public class ArraySortUtil {
	//求和
	//static 静态方法
	public static int sum(int i, int j, int x){
		int sum = i + j + x;
		return sum;
	}
	
	public static int sum(int i, int j) {
		return i + j;
	}
	
	
	public static int sum(double i, double j) {
		return (int)(i + j);
	}
	
	public static int sum(int i, int j, int x, int y) {
		return i + j + x + y;
	}
	
	/**
	 * 选择排序
	 * @param array
	 */
	public static void selectSort(int[] array) {
		for(int j = 0 ; j < array.length; j++) {
			int min = array[j];
			int index = j;
			for(int i = j; i < array.length; i++) {
				if(min > array[i]) {
					min = array[i];
					index = i;
				}
			}
			
			swap(array, j, index);
		}
		
		//遍历数组
		displayArray(array);
	}
	
	/**
	 * 冒泡排序
	 * @param array  传入一个数组
	 */
	public static void maoPaoSort(int[] array){
		for(int i = 0; i < array.length - 1; i++) {
			for(int j = 0; j < array.length - 1 - i; j++) {
				if(array[j] > array[j + 1]){
					swap(array, j, j + 1);
				}
			}
		}
		
		//遍历数组
		displayArray(array);
	}
	
	/**
	 * 交换两个数
	 * @param a
	 * @param b
	 */
	public static void swap(int[] array, int a, int b) {
//		int tmp = b;
//		b = a;
//		a = tmp;
		int tmp = array[b];
		array[b] = array[a];
		array[a] = tmp;
	}
	
	//遍历数组
	public static void displayArray(int[] array) {
		for(int i = 0; i < array.length; i++) {
			System.out.print(array[i] + " ");
		}
		
	}
}
